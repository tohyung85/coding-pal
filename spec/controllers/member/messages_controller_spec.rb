require 'rails_helper'

RSpec.describe Member::MessagesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:enrollment) { FactoryGirl.create(:enrollment) }
  let(:group) { FactoryGirl.create(:group) }
  describe '#new' do
    context 'user signed in' do
      render_views
      before do
        # sign_in enrollment.user
      end
      it 'should allow member to view create message page' do
        # get :new, group_id: enrollment.group.id
        # puts enrollment.inspect
        # expect(response).to have_http_status(:success)
      end
      it 'should not allow non-members to view create message page' do
        # get :new, group_id: enrollment.group.id
        # expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
