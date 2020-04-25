require 'rails_helper'

RSpec.describe "AdminUsers", type: :request do
  describe "GET #index" do
    let(:admin_user) { FactoryBot.create :admin }
    let!(:user_a) { FactoryBot.create :user}
    context '管理者である場合' do
      before do
        sign_in admin_user
      end
      it 'リクエストが成功すること' do
        get admins_users_url
        expect(response.status).to eq 200
      end
      it 'ユーザー名が表示されていること' do
        get admins_users_url
        expect(response.body).to include user_a.name
      end
      it 'emailが表示されていること' do
        get admins_users_url
        expect(response.body).to include user_a.email
      end
      it 'ステータスが表示されていること' do
        get admins_users_url
        expect(response.body).to include user_a.status
      end
    end
    context '管理者でない場合' do
      it 'リダイレクトすること' do
        get admins_users_url
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end
end
