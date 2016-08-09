require 'rails_helper'

RSpec.describe EnrollmentsController, type: :controller do
  let(:group) { FactoryGirl.create(:group) }
  let(:user) { FactoryGirl.create(:user) }
  let(:request) { FactoryGirl.create(:join_request) }
  describe '#create' do
    context 'user signed in' do
      before do
        sign_in user
      end

      it 'should allow user to create an enrollment' do
        post :create, group_id: group.id

        expect(group.members.find_by_id(user)).to eq(user)
        expect(user.enrolled_groups.find_by_id(group)).to eq(group)
        expect(response).to redirect_to group_path(group)
      end

      it 'should return a 404 error if group is not found' do
        post :create, group_id: 'some id'

        expect(group.members.find_by_id(user)).to eq nil
        expect(user.enrolled_groups.find_by_id(group)).to eq nil
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'user not signed in' do
      it 'should not allow user to create an enrollment' do
        expect { post :create, group_id: group.id }.to_not change { Enrollment.count }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
