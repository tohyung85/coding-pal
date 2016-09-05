require 'rails_helper'

RSpec.describe SuggestionsController, type: :controller do
  describe '#create' do
    context 'user signed in or not' do
      it 'should allow user to send suggestion' do
        expect do
          post :create, suggestion: {
            user_email: 'johndoe@gmail.com',
            title: 'Nice App',
            description: 'i like'
          }
        end.to change { Suggestion.count }.by 1
      end
    end
  end
end
