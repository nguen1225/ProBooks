require 'rails_helper'

RSpec.feature 'User', type: :feature do
  feature '機能' do
    background do
      visit root_path
    end

    scenario '新規登録できる' do
      click_on '新規登録'
      expect(current_path).to eq new_user_registration_path

      fill_in  '名前', with: 'テスト'
      fill_in  'メールアドレス', with: 'test@example.com'
      fill_in  'パスワード', with: 'foobar'
      fill_in  'パスワード（確認用）', with: 'foobar'
      click_on '登録'

      expect(page).to have_content 'Welcome!'
    end
  end

  feature 'レイアウト' do
    background do
      visit new_user_registration_path
    end

    scenario '新規登録後ヘッダー画面が変更' do
      fill_in '名前', with: 'テスト'
      fill_in  'メールアドレス', with: 'test@example.com'
      fill_in  'パスワード', with: 'foobar'
      fill_in  'パスワード（確認用）', with: 'foobar'
      click_on '登録'

      expect(current_path).to eq root_path
      expect(page).to have_content '本投稿'
      expect(page).to have_content '書籍を探す'
      expect(page).to have_content 'ログアウト'
    end
  end
end
