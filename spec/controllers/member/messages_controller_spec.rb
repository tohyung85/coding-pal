require 'rails_helper'

RSpec.describe Member::MessagesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:enrollment) { FactoryGirl.create(:enrollment) }
  let(:group) { FactoryGirl.create(:group) }
  let(:message) { FactoryGirl.create(:message) }
  describe '#new' do
    context 'user signed in' do
      render_views

      before do
        sign_in enrollment.user
      end

      it 'should allow member to view create message page' do
        get :new, group_id: enrollment.group.id

        expect(response).to have_http_status(:success)
      end
      it 'should not allow non-members to view create message page' do
        sign_in user

        get :new, group_id: enrollment.group.id

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe '#edit' do
    context 'user signed in' do
      render_views

      before do
        sign_in message.user
      end

      it 'should allow member to view edit message page' do
        get :edit, group_id: message.group.id, id: message.id

        expect(response).to have_http_status(:success)
      end

      it 'should only allow owner of message to edit' do
        sign_in user

        get :edit, group_id: message.group.id, id: message.id

        expect(response).to have_http_status(:unauthorized)
      end

      it 'should return 404 error if not found' do
        get :edit, group_id: message.group.id, id: 'some message'

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#create' do
    context 'user signed in' do
      render_views

      before do
        sign_in enrollment.user
      end

      it 'should allow members to create message' do
        expect do
          post :create, group_id: enrollment.group.id, message: {
            message_title: 'Meeting now!',
            message_description: 'Yes right now!'
          }
        end.to change { Message.count }.by 1
        expect(response).to redirect_to member_group_path(enrollment.group)
      end

      it 'should not allow non members to create message' do
        sign_in user

        expect do
          post :create, group_id: enrollment.group.id, message: {
            message_title: 'Cheeky business',
            message_description: 'gonna spam you now'
          }
        end.to_not change { Message.count }
        expect(response).to have_http_status(:unauthorized)
      end

      it 'should return 404 error if group not found' do
        expect do
          post :create, group_id: 'nonsense id', message: {
            message_title: 'Cheeky business',
            message_description: 'gonna spam you now'
          }
        end.to_not change { Message.count }
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'user not signed in' do
      render_views

      it 'should redirect user to sign in page' do
        expect do
          post :create, group_id: enrollment.group.id, message: {
            message_title: 'Meeting now!',
            message_description: 'Yes right now!'
          }
        end.to_not change { Message.count }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#update' do
    before do
      message
    end

    context 'user signed in' do
      render_views

      before do
        sign_in message.user
      end

      it 'should allow owner of message to update' do
        patch :update, group_id: message.group.id, id: message.id, message: {
          message_title: 'I made changes',
          message_description: 'many changes'
        }

        message.reload

        expect(message.message_title).to eq 'I made changes'
        expect(message.message_description).to eq 'many changes'
        expect(response).to redirect_to group_path(message.group)
      end

      it 'should not allow non owner to update message' do
        sign_in user

        patch :update, group_id: message.group.id, id: message.id, message: {
          message_title: 'I made changes',
          message_description: 'many changes'
        }

        message.reload

        expect(message.message_title).to eq 'Group announcement'
        expect(message.message_description).to eq 'Let us have fun'
        expect(response).to have_http_status(:unauthorized)
      end

      it 'should return 404 error if message not found' do
        patch :update, group_id: message.group.id, id: 'YOLO message', message: {
          message_title: 'I made changes',
          message_description: 'many changes'
        }

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'user not signed in' do
      render_views

      it 'should redirect user back to sign in page' do
        patch :update, group_id: message.group.id, id: message.id, message: {
          message_title: 'I made changes',
          message_description: 'many changes'
        }

        expect(message.message_title).to eq 'Group announcement'
        expect(message.message_description).to eq 'Let us have fun'
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#destroy' do
    context 'user signed in' do
      render_views
      before do
        sign_in message.user
      end
      it 'should allow owner to delete message' do
        expect do
          delete :destroy, group_id: message.group.id, id: message.id
        end.to change { Message.count }.by(-1)
        expect(response).to redirect_to group_path(message.group)
      end

      it 'should not allow non owners to delete message' do
        sign_in user

        expect do
          delete :destroy, group_id: message.group.id, id: message.id
        end.to_not change { Message.count }
        expect(response).to have_http_status(:unauthorized)
      end

      it 'should return 404 error if not found' do
        delete :destroy, group_id: message.group.id, id: 'some message'

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'user not signed in' do
      render_views
      it 'should redirect user to sign in page' do
        message

        expect do
          delete :destroy, group_id: message.group.id, id: message.id
        end.to_not change { Message.count }

        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
