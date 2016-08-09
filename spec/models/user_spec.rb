require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create_profile' do
    it 'should create a new profile for the user' do
      user = FactoryGirl.create(:user)
      expect(user.profile.user_id).to eq(user.id)
      expect(user.profile.user_name).to eq(user.email)
    end
  end
end
