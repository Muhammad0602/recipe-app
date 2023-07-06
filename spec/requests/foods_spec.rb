require 'rails_helper'

RSpec.describe '/foods', type: :request do

  describe 'GET /index' do
    before { get '/foods' }

    it 'return http success' do
      follow_redirect!
      expect(response).to have_http_status(:success)
    end

    it 'renderes a correct template' do
      expect(response).to render_template(:index)
    end

    it ' the body returns the correct placeholder' do
      expect(response.body).to include('Foods')
    end
  end
end
