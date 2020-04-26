require 'rails_helper'

RSpec.describe 'Notifications', type: :request do
  let(:user_a) { FactoryBot.create :user }
  describe 'GET #index' do
    context '正しいユーザーの場合' do
      before do
        sign_in user_a
      end
      it 'リクエストが成功すること（更新処理あり）' do
        get notifications_url
        expect(response.status).to eq 302
      end
    end
    context 'ログインしていないユーザーの場合' do
      it 'リダイレクトすること' do
        get notifications_url
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
