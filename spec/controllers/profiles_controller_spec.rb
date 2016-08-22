require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:profile) { FactoryGirl.create(:profile) }
  describe '#index' do
    context 'user signed in or not' do
      render_views
      it 'should show the index page with all user profiles' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#show' do
    context 'user signed in or not' do
      render_views
      it 'should show the user profile' do
        get :show, id: user.profile.id
        expect(response).to have_http_status(:success)
      end

      it 'should show 404 error if id is not found' do
        get :show, id: 'some id'
        expect(response).to have_http_status(:not_found)
      end
    end
  end
  describe '#edit' do
    context 'user_signed in' do
      before do
        sign_in user
      end
      render_views
      it 'should allow user to edit his profile page' do
        get :edit, id: user.id
        expect(response).to have_http_status(:success)
      end

      it 'should not allow user to edit another user profile' do
        get :edit, id: user2.id
        expect(response).to have_http_status(:unauthorized)
      end

      it 'should return not found if user id is invalid' do
        get :edit, id: 'rpec test'
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'user not signed in' do
      render_views
      it 'should not allow a user who is not signed in to access edit page' do
        get :edit, id: 123
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#update' do
    context 'user_signed in' do
      before do
        sign_in user
      end
      it 'should allow user to update his profile page' do
        patch :update, id: user.id, profile: {
          user_name: 'John Doe'
        }
        user.profile.reload
        expect(user.profile.user_name).to eq('John Doe')
        expect(response).to redirect_to profile_path(user)
      end

      it 'should not allow user to update another user profile' do
        patch :update, id: user2.id, profile: {
          user_name: 'John Doe'
        }
        user2.profile.reload
        expect(user2.profile.user_name).to eq user2.email
        expect(response).to have_http_status(:unauthorized)
      end

      it 'should return not found if user id is invalid' do
        get :edit, id: 'rspec test'
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'user not signed in' do
      render_views
      it 'should not allow a user who is not signed in to access edit page' do
        get :edit, id: 123
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
