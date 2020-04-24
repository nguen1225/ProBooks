require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe 'GET /homes' do
    it '正常なレスポンスを返すこと' do
      get root_path
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
end
