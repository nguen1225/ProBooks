require 'rails_helper'

RSpec.describe 'お気に入り機能', type: :system, js: true do
  include LoginSupport
  let(:user) { create(:user) }
  let(:category_html) { create(:category, name: 'html&css') }
  let(:category_javascript) { create(:category, name: 'javascript') }
  let!(:book_first) { create(:book,  title: 'テスト駆動開発1', level: 'easy', volume: 'few', category: category_html, user: user) }
  let!(:book_second) { create(:book, title: 'テスト駆動開発2', level: 'normal', volume: 'medium', category: category_javascript, user: user) }

  before do
    sign_in_as user
  end

  it 'お気に入りボタンの表示が変更' do
    visit book_path(book_first)
    click_on 'お気に入りに追加'
    expect(page).to have_content 'お気に入りから外す'
  end

  it 'お気に入り登録後マイページに追加されている' do
    expect do
      visit book_path(book_first)
      click_on 'お気に入りに追加'
      sleep 1.0
    end.to change { Favorite.count }.by(1)

    expect do
      visit book_path(book_second)
      click_on 'お気に入りに追加'
      sleep 1.0
    end.to change { Favorite.count }.by(1)

    find('.sidenav-trigger').click
    click_on 'マイページ'
    expect(page).to have_content(book_first.title)
    expect(page).to have_content(book_second.title)
  end

  it 'お気に入りから外すことができる' do
    expect do
      visit book_path(book_first)
      click_on 'お気に入りに追加'
      sleep 1.0
    end.to change { Favorite.count }.by(1)

    expect(page).to have_content 'お気に入りから外す'
    # マイページ移動
    find('.sidenav-trigger').click
    click_on 'マイページ'
    expect(page).to have_content(book_first.title)
    click_link '詳細'

    expect do
      click_on 'お気に入りから外す'
      sleep 0.5
    end.to change { Favorite.count }.by(-1)

    expect(page).to have_content 'お気に入りに追加'
    # マイページ移動
    find('.sidenav-trigger').click
    click_on 'マイページ'
    expect(page).to have_no_content(book_first.title)
  end
end
