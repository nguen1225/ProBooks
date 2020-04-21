require 'rails_helper'

RSpec.describe 'Book Tag UI', type: :system do
  before do
    user = FactoryBot.create(:user)
    first_category = FactoryBot.create(:category, name: "html&css")
    second_category = FactoryBot.create(:category, name: "ruby")
    visit new_user_session_path
    fill_in  'メールアドレス', with: user.email
    fill_in  'パスワード', with: user.password
    click_on 'Log In'
  end

  it '同じタグの書籍が複数表示される', js: true, must: true do
    visit new_book_path
    # 書籍の登録(１冊目)
    expect {
      fill_in 'タイトル', with: 'テスト'
      fill_in '内容', with: 'テストしました'
      all('.input-text input')[1].click
      find("li", text: "html&css").click
      all('.input-text input')[2].click
      find("li", text: "Hard").click
      all('.input-text input')[3].click
      find('li', text: "Medium").click
      fill_in 'タグ', with: '#テストタグ'
      attach_file 'book[image]', 'app/assets/images/default.jpg'
      click_on '登録'
    }.to change{Book.count}.by(1)

    expect(page).to have_content '#テストタグ'

    find('.sidenav-trigger').click
    click_link '書籍の投稿'

    # 書籍の登録（２冊目）
    expect {
      fill_in 'タイトル', with: '２回目の投稿'
      fill_in '内容', with: '２回目です'
      all('.input-text input')[1].click
      find("li", text: "ruby").click
      all('.input-text input')[2].click
      find("li", text: "Normal").click
      all('.input-text input')[3].click
      find('li', text: "Few").click
      fill_in 'タグ', with: '#テストタグ'
      attach_file 'book[image]', 'app/assets/images/default.jpg'
      click_on '登録'
    }.to change{Book.count}.by(1)

    expect(page).to have_content '#テストタグ'
    click_link '#テストタグ'

    #　同じタグの書籍が表示されている
    expect(page).to have_content 'テスト'
    expect(page).to have_content '２回目の投稿'
  end
end
