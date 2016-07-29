require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  let(:user){FactoryGirl.create(:user)}
  let(:profile){FactoryGirl.create(:profile)}
  context 'user_signed in' do
    render_views
    it 'should allow user to edit his profile page' do
      sign_in user
      get :edit, id: user.id
      expect(response).to have_http_status(:success)
    end

    it 'should not allow user to edit another user profile' do
      sign_in user
      user2 = FactoryGirl.create(:user)
      get :edit, id: user2.id
      expect(response).to have_http_status(:unauthorized)
    end

    it 'should allow user to update his profile page' do
      sign_in user
      patch :update, id: user.id, profile: {
        user_name: 'John Doe'
      }      
      user.profile.reload
      expect(user.profile.user_name).to eq('John Doe')
      expect(response).to redirect_to edit_profile_path
    end

  end

end
