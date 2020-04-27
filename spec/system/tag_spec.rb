require 'rails_helper'

RSpec.describe 'タグ機能', type: :system do
  include LoginSupport
  let(:user) { create(:user) }
  let!(:first_category) { create(:category, name: 'html&css') }
  let!(:second_category) { create(:category, name: 'ruby') }

  before do
    sign_in_as user
  end

  it '同じタグの書籍が複数表示される', js: true, must: true do
    visit new_book_path
    # 書籍の登録(１冊目)
    expect do
      fill_in 'タイトル', with: 'テスト'
      fill_in '内容', with: 'テストしました'
      all('.input-text input')[1].click
      find('li', text: 'html&css').click
      all('.input-text input')[2].click
      find('li', text: 'むずかしい').click
      all('.input-text input')[3].click
      find('li', text: 'ふつう').click
      fill_in 'タグ', with: '#テストタグ'
      click_on '登録'
    end.to change { Book.count }.by(1)

    expect(page).to have_content '#テストタグ'

    find('.sidenav-trigger').click
    click_link '書籍の投稿'

    # 書籍の登録（２冊目）
    expect do
      fill_in 'タイトル', with: '２回目の投稿'
      fill_in '内容', with: '２回目です'
      all('.input-text input')[1].click
      find('li', text: 'ruby').click
      all('.input-text input')[2].click
      find('li', text: 'ふつう').click
      all('.input-text input')[3].click
      find('li', text: 'すくない').click
      fill_in 'タグ', with: '#テストタグ'
      click_on '登録'
    end.to change { Book.count }.by(1)

    expect(page).to have_content '#テストタグ'
    click_link '#テストタグ'

    # 　同じタグの書籍が表示されている
    expect(page).to have_link 'テスト'
    expect(page).to have_link '２回目の投稿'
  end
end
