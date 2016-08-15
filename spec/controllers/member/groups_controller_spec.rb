require 'rails_helper'

RSpec.describe Member::GroupsController, type: :controller do
  let(:group) { FactoryGirl.create(:group) }
  describe '#show' do
    context 'user signed in' do
      it 'should show page if user is a member' do
        sign_in group.user
        get :show, id: group.id
        expect(response).to have_http_status(:success)
      end
    end
  end
end
