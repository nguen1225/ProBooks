require 'rails_helper'

RSpec.feature 'Session', type: :feature do
  before do
    @user = FactoryBot.create(:user)
    visit new_user_session_path
    fill_in  'メールアドレス', with: 'test@example.com'
    fill_in  'パスワード', with: 'foobar'
    click_on 'Log In'
  end
  describe '機能' do
    it 'ログインできる' do
      expect(page).to have_content 'Signed in successfully'
    end
  end
  describe 'レイアウト' do
    it 'ログイン後ヘッダーレイアウトが変更' do
      expect(current_path).to eq root_path
      expect(page).to have_content '本投稿'
      expect(page).to have_content '書籍を探す'
      expect(page).to have_content 'ログアウト'
    end
  end
end
