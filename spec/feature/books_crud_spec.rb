require 'rails_helper'

RSpec.feature '書籍CRUD', type: :feature do
  include LoginSupport

  background do
    user = FactoryBot.create(:user)
    sign_in_as user
  end

  scenario '書籍を登録することができる' do
    visit new_book_path
    fill_in 'Title', with: 'テスト'
    fill_in 'Content', with: 'テストしました'
    select 'Html', from: 'Category'
    click_on 'Create Book'

    expect(page).to have_content 'テスト'
    expect(page).to have_content 'テストしました'
    expect(page).to have_content 'html'
  end

  scenario '書籍の編集ができる' do
    # 書籍の登録
    visit new_book_path
    fill_in 'Title', with: 'テスト'
    fill_in 'Content', with: 'テスト'
    select 'Html', from: 'Category'
    click_on 'Create Book'

    expect(page).to have_link '編集'
    click_link '編集'
    # 編集項目入力
    fill_in 'Title', with: '変更'
    fill_in 'Content', with: '変更しました'
    select 'Ruby', from: 'Category'
    click_on 'Update Book'

    expect(page).to have_content '変更'
    expect(page).to have_content '変更しました'
    expect(page).to have_content 'ruby'
  end

  scenario '書籍の削除ができる' do
    visit new_book_path
    fill_in 'Title', with: 'テスト'
    fill_in 'Content', with: 'テスト'
    select 'Html', from: 'Category'
    click_on 'Create Book'

    expect(page).to have_link '削除'
    click_link '削除'

    expect(page).to have_content('削除しました')
  end
end
