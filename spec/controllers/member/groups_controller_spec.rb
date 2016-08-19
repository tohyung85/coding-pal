require 'rails_helper'

RSpec.describe Member::GroupsController, type: :controller do
  let(:group) { FactoryGirl.create(:group) }
  let(:user) { FactoryGirl.create(:user) }
  let(:enrollment) { FactoryGirl.create(:enrollment) }
  describe '#show' do
    context 'user signed in' do
      before do
        sign_in enrollment.user
      end
      it 'should show page if user is a member' do
        get :show, id: enrollment.group.id
        expect(response).to have_http_status(:success)
      end
      it 'should return unauthorized if user is not a member' do
        sign_in user
        get :show, id: enrollment.group.id
        expect(response).to have_http_status(:unauthorized)
      end
      it 'should return 404 error if not found' do
        get :show, id: 'some id'
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'user not signed in' do
      it 'should redirect user to sign in page' do
        get :show, id: enrollment.group.id
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
