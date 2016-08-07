require 'rails_helper'

RSpec.describe JoinRequestsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:group) { FactoryGirl.create(:group) }
  let(:request) { FactoryGirl.create(:join_request) }

  describe '#create' do
    render_views

    context 'user signed in' do
      before do
        sign_in user
      end

      it 'should allow user to create a request to join group' do
        expect do
          post :create, group_id: group.id
        end.to change { JoinRequest.count }.by 1

        expect(response).to redirect_to group_path(group)
      end
      it 'should return 404 error if group not found' do
        expect do
          post :create, group_id: 'YOLOgroup'
        end.to_not change { JoinRequest.count }

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'user not signed in' do
      it 'should not allow user to create request and redirect to sign in page' do
        expect do
          post :create, group_id: group.id
        end.to_not change { JoinRequest.count }

        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#destroy' do
    render_views

    context 'requestor signed in' do
      before do
        sign_in request.requestor
      end

      it 'should allow requestor to destroy or cancel join request' do
        expect do
          delete :destroy, id: request.id
        end.to change { JoinRequest.count }.by -1

        expect(response).to redirect_to group_path(request.group)
      end

      it 'should not allow non-requestors to destroy or cancel join request' do
        sign_in user

        expect do
          delete :destroy, id: request.id
        end.to_not change { JoinRequest.count }

        expect(response).to have_http_status(:unauthorized)
      end

      it 'should return 404 error if request not found' do
        expect do
          delete :destroy, id: 'fakerequestid'
        end.to_not change { JoinRequest.count }

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'group owner signed in' do
      before do
        sign_in request.group.user
      end

      it 'should allow group owner to destroy or reject join request' do
        expect do
          delete :destroy, id: request.id
        end.to change { JoinRequest.count }.by -1

        expect(response).to redirect_to group_path(request.group)
      end
    end

    context 'user not signed in' do
      it 'should redirect user to sign in page' do
        request

        expect do
          delete :destroy, id: request.id
        end.to_not change { JoinRequest.count }

        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#enroll' do
    context 'group owner signed in' do
      before do
        sign_in request.group.user
      end

      it 'should allow owner to enroll requestor' do
        expect do
          delete :enroll, join_request_id: request.id
        end.to change { JoinRequest.count }.by -1

        expect(request.group.members.find_by_id(request.requestor.id)).to_not eq nil
        expect(response).to redirect_to group_path(request.group)
      end

      it 'should not allow non-owner to enroll requestor' do
        sign_in user

        expect do
          delete :enroll, join_request_id: request.id
        end.to_not change { JoinRequest.count }

        expect(request.group.members.find_by_id(request.requestor.id)).to eq nil
        expect(response).to have_http_status(:unauthorized)
      end

      it 'should return 404 error if request not found' do
        expect do
          delete :enroll, join_request_id: 'someID'
        end.to_not change { JoinRequest.count }

        expect(request.group.members.find_by_id(request.requestor.id)).to eq nil
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'no user sign in' do
      it 'should redirect user to sign in page' do
        request

        expect do
          delete :enroll, join_request_id: request.id
        end.to_not change { JoinRequest.count }

        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
