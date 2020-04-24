require 'rails_helper'

RSpec.describe '書籍CRUD', type: :system do
  include LoginSupport

  # let(:image_path) { File.join(Rails.root, 'spec/fixtures/default.jpg') }
  # let(:image) { Rack::Test::Uploaded.new(image_path)}
  let(:category_html) { FactoryBot.create(:category, name: 'html&css') }
  let(:user) { FactoryBot.create(:user) }
  let!(:book) { FactoryBot.create(:book, user: user, category: category_html) }

  before do
    FactoryBot.create(:category, name: 'ruby')
    sign_in_as user
  end

  it '書籍を登録することができる', js: true do
    visit new_book_path
    expect do
      fill_in 'タイトル', with: 'テスト'
      fill_in '内容', with: 'テストしました'
      all('.input-text input')[1].click
      find('li', text: 'html&css').click
      all('.input-text input')[2].click
      find('li', text: 'Hard').click
      all('.input-text input')[3].click
      find('li', text: 'Medium').click
      fill_in 'タグ', with: '#テストタグ'
      attach_file 'book[image]', 'app/assets/images/default.jpg'
      click_on '登録'
    end.to change { Book.count }.by(1)

    # 登録後詳細ページへ遷移
    expect(page).to have_content 'テスト'
    expect(page).to have_content 'テストしました'
    expect(page).to have_content '#テストタグ'
    expect(page).to have_selector("img[src$='default.jpg']")
    expect(page).to have_content 'hard'
    expect(page).to have_content 'medium'
    expect(page).to have_content 'html&css'
  end

  it '書籍の編集ができる', js: true do
    visit edit_book_path(book)

    fill_in 'タイトル', with: '変更'
    fill_in '内容', with: '変更しました'
    all('.input-text input')[1].click
    find('li', text: 'ruby').click
    all('.input-text input')[2].click
    find('li', text: 'Normal').click
    all('.input-text input')[3].click
    find('li', text: 'Many').click
    attach_file 'book[image]', 'app/assets/images/clap.jpg'
    click_on '更新'

    # 編集後詳細ページへ遷移
    expect(page).to have_content '変更'
    expect(page).to have_content '変更しました'
    expect(page).to have_selector("img[src$='clap.jpg']")
    expect(page).to have_content 'normal'
    expect(page).to have_content 'many'
    expect(page).to have_content 'ruby'
  end

  # jsダイアログの表示がうまくいかない
  # it '書籍の削除ができる',js: true do
  #   book = FactoryBot.create(:book, user_id: @user.id, category_id: @category_first.id)
  #   visit book_path(book)

  #   expect(page).to have_link '削除'
  #   click_link '削除'
  #   accept_confirm { click_link '削除' }

  #   expect(page).to have_content('削除しました')
  # en
end
