require 'rails_helper'

RSpec.describe 'TopPage', type: :system do
  before do
    visit root_path
  end

  it '新規登録リンクをクリックするとリンクへ遷移する' do
    click_link 'Sign Up'
    expect(current_path).to eq new_user_registration_path
  end

  it 'ログインリンクをクリックするとログインページ遷移' do
    click_link 'Log In'
    expect(current_path).to eq new_user_session_path
  end

  context 'About' do
    it '登録してみるリンクが正常であること' do
      click_link '登録してみる'
      expect(current_path).to eq new_user_registration_path
    end

    it '書籍を探すリンクが正常であること' do
      click_link '書籍を探す'
      expect(current_path).to eq books_path
    end
  end
end
