require 'rails_helper'

RSpec.describe 'AdminDashboards', type: :request do
  let(:admin_user) { FactoryBot.create :admin }
  describe 'GET #index' do
    context '管理者である場合' do
      before do
        sign_in admin_user
      end
      it 'リクエストが成功すること' do
        get admins_root_url
        expect(response.status).to eq 200
      end
    end
    context '管理者でない場合' do
      it 'リダイレクトすること ' do
        get admins_root_url
        expect(response).to redirect_to admin_session_url
      end
    end
  end
end
