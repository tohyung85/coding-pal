require 'rails_helper'

RSpec.describe UserMessagesController, type: :controller do
  let(:receiving_user) { FactoryGirl.create(:user) }
  let(:sending_user) { FactoryGirl.create(:user) }
  let(:user_message) { FactoryGirl.create(:user_message) }
  describe '#new' do
    context 'user signed in' do
      before do
        sign_in sending_user
      end
      it 'should allow user to access page' do
        get :new, user_id: receiving_user.id
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#create' do
    context 'user signed in' do
      before do
        request.env['HTTP_REFERER'] = profile_path(receiving_user)
        sign_in sending_user
      end
      it 'should allow sender to create a message' do
        expect do
          post :create, user_id: receiving_user.id, user_message: {
            message_title: 'Hey man!',
            message_description: 'How is life?'
          }
        end.to change { UserMessage.count }.by 1

        expect(receiving_user.received_messages.last.sender).to eq sending_user
        expect(response).to redirect_to profile_path(receiving_user)
      end

      it 'should return 404 error if user is sending to an invalid user' do
        expect do
          post :create, user_id: 'some fictitious user', user_message: {
            message_title: 'Hey man!',
            message_description: 'How is life?'
          }
        end.to_not change { UserMessage.count }
      end
    end

    context 'user not signed in' do
      before do
        request.env['HTTP_REFERER'] = profile_path(receiving_user)
      end

      it 'should redirect user to sign in page' do
        expect do
          post :create, user_id: receiving_user.id, user_message: {
            message_title: 'Hey man!',
            message_description: 'How is life?'
          }
        end.to_not change { UserMessage.count }

        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
