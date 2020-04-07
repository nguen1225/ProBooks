require 'rails_helper'

RSpec.feature '書籍登録', type: :feature do
  background do
    user = FactoryBot.create(:user)
    visit new_user_session_path
    fill_in  'メールアドレス', with: 'test@example.com'
    fill_in  'パスワード', with: 'foobar'
    click_on 'Log In'
  end
  scenario '書籍を登録することができる' do
    visit new_book_path
    fill_in 'Title', with: 'テスト'
    fill_in 'Content', with: 'テスト'
    select 'html', from: 'Category'
    click_on 'CREATE BOOK'

    expect(page).to have_content 'テスト'
    expect(page).to have_content 'テストテスト'
    expect(page).to have_content 'html'
  end
end
