require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  context 'user enters webpage' do
    render_views
    it 'should show landing page' do
      get :landing_page
      expect(response).to have_http_status(:success)
    end
  end

end
