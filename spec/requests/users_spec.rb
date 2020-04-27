require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let!(:user_a) { FactoryBot.create :user_a }

  describe 'GET #show' do
    context 'ユーザが存在する場合' do
      before do
        sign_in user_a
      end
      it '正常なレスポンスを返すこと' do
        get user_url user_a
        expect(response.status).to eq 200
      end
      it 'ユーザー名が表示されていること' do
        get user_url user_a
        expect(response.body).to include 'Sato'
      end
    end

    # context 'ユーザーが存在しない場合' do
    #   subject { -> { get user_url 1 } }
    #   it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    # end
  end

  # describe 'GET #edit' do
  #   it '正常なレスポンスを返すこと' do
  #     get edit_user_url user_a
  #     expect(response.status).to eq 200
  #   end
  #   it 'ユーザ名が表示されていること' do
  #     get edit_user_url user_a
  #     expect(response.body).to include 'Sato'
  #   end
  #   it 'メールアドレスが表示されていること' do
  #     get edit_user_url user_a
  #     expect(response.body).to include 'sato@example.com'
  #   end
  #   it 'ステータスが表示されていること' do
  #     get edit_user_url user_a
  #     expect(response.body).to include 'engineer'
  #   end
  #   it '自己紹介文が表示されていること' do
  #     get edit_user_url user_a
  #     expect(response.body).to include 'テストユーザーの自己紹介'
  #   end

  #   context 'ユーザーが存在しない場合', must: true do
  #     subject { -> { get user_url 1 } }
  #     it { is_expected.to raise_error ActiveRecord::RecordNotFound }
  #   end
  # end

  describe 'PUT #update' do
    context '正常なパラメータの場合' do
      it 'リクエストが成功すること' do
        put user_url user_a, params: { user: FactoryBot.attributes_for(:user_b) }
        expect(response.status).to eq 302
      end
      it 'ユーザー名が更新されること' do
        expect do
          put user_url user_a, params: { user: FactoryBot.attributes_for(:user_b) }
        end.to change { User.find(user_a.id).name }.from('Sato').to('Suzuki')
      end
      it 'リダイレクトすること' do
        put user_url user_a, params: { user: FactoryBot.attributes_for(:user_b) }
        expect(response).to redirect_to User.last
      end
    end

    context '不正なパラメータの場合' do
      it 'リクエストが成功すること' do
        put user_url user_a, params: { user: FactoryBot.attributes_for(:user, :invalid) }
        expect(response.status).to eq 200
      end
      it 'ユーザー名が更新されない', must: true do
        expect do
          put user_url user_a, params: { user: FactoryBot.attributes_for(:user, :invalid) }
        end.to_not change(User.find(user_a.id), :name)
      end
      it 'エラーが表示されること', must: true do
        put user_url user_a, params: { user: FactoryBot.attributes_for(:user, :invalid) }
        expect(response.body).to include '名前を入力してください'
      end
    end
  end
end
