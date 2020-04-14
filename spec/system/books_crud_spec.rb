require 'rails_helper'

RSpec.describe '書籍CRUD', type: :system do
  include LoginSupport

  # let(:image_path) { File.join(Rails.root, 'spec/fixtures/default.jpg') }
  # let(:image) { Rack::Test::Uploaded.new(image_path)}

  before do
    user = FactoryBot.create(:user)
    sign_in_as user
  end

  it '書籍を登録することができる', js: true do
    visit new_book_path
    fill_in 'Title', with: 'テスト'
    fill_in 'Content', with: 'テストしました'
    attach_file 'book[image]', 'app/assets/images/rails.png'
    click_on 'Create Book'

    expect(page).to have_content 'テスト'
    expect(page).to have_content 'テストしました'
    expect(page).to have_selector("img[src$='rails.png']")
    expect(page).to have_content 'html'
  end

#   it '書籍の編集ができる' do
#     # 書籍の登録
#     visit new_book_path
#     fill_in 'Title', with: 'テスト'
#     fill_in 'Content', with: 'テスト'
#     attach_file 'book[image]', 'app/assets/images/rails.png'
#     select 'Html', from: 'Category'
#     click_on 'Create Book'

#     expect(page).to have_link '編集'
#     click_link '編集'
#     # 編集項目入力
#     fill_in 'Title', with: '変更'
#     fill_in 'Content', with: '変更しました'
#     attach_file 'book[image]', 'app/assets/images/forest.jpg'
#     select 'Ruby', from: 'Category'
#     click_on 'Update Book'

#     expect(page).to have_content '変更'
#     expect(page).to have_content '変更しました'
#     expect(page).to have_selector("img[src$='forest.jpg']")
#     expect(page).to have_content 'ruby'
#   end

#   it '書籍の削除ができる' do
#     visit new_book_path
#     fill_in 'Title', with: 'テスト'
#     fill_in 'Content', with: 'テスト'
#     attach_file 'book[image]', 'app/assets/images/rails.png'
#     select 'Html', from: 'Category'
#     click_on 'Create Book'

#     expect(page).to have_link '削除'
#     click_link '削除'

#     expect(page).to have_content('削除しました')
#   end
end
