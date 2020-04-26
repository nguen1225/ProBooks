require 'rails_helper'

RSpec.describe 'UserSessions', type: :request do
  describe 'GET #new' do
    let!(:user) { FactoryBot.create(:user) }
    context 'ユーザーが存在する場合' do
      it '正常なレスポンスを返す' do
        get new_user_session_url
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST #create' do
    let(:user) { FactoryBot.create(:user) }
    let(:req_params) { { session_form: { user: user } } }
    context 'ユーザーが存在する場合' do
      it 'リクエストが成功すること' do
        post user_session_url, params: req_params
        expect(response.status).to eq 200
      end
    end
    context 'ユーザーが存在しない場合' do
      it 'リクエストが成功すること' do
        post user_session_url, params: { user: FactoryBot.attributes_for(:user_b, :invalid) }
        expect(response.status).to eq 200
      end
      it 'リダイレクトすること' do
        post user_session_url, params: { user: FactoryBot.attributes_for(:user_b, :invalid) }
        expect(response).to redirect_to new_user_session_url
      end
    end
  end
end
