require 'rails_helper'

RSpec.describe 'レビュー機能', type: :system, js: true do
  include LoginSupport

  let(:user_a) { create(:user) }
  let(:user_b) { create(:user) }
  let(:category) { create(:category) }
  let(:book) { create(:book, user: user_a, category: category) }
  let(:review) { create(:review, user: user_b, book: book) }

  it 'レビューを投稿できる' do
    # ログインしてレビューを投稿
    sign_in_as user_a
    visit book_path(book)
    find('.modal-trigger').click

    expect do
      page.all('#star img')[1].click
      fill_in 'review[title]', with: '評価１'
      fill_in 'review[body]', with: 'テスト内容'
      click_on '評価する'
      sleep 1.0
    end.to change { Review.count }.by(1)

    # 投稿した内容が表示される
    expect(page).to have_content '投稿しました'
    expect(page).to have_content '評価１'
    expect(page).to have_content 'テスト内容'
    expect(page).to have_link '削除'
  end

  it '自分の投稿したレビュー以外削除できない' do
    # ログイン（一人目）
    sign_in_as user_a
    # レビューの投稿 -> レビューカウントが増える
    visit book_path(book)
    find('.modal-trigger').click

    expect do
      page.all('#star img')[1].click
      fill_in 'review[title]', with: '評価１'
      fill_in 'review[body]', with: 'テスト内容'
      click_on '評価する'
      sleep 1.0
    end.to change { Review.count }.by(1)

    find('.sidenav-trigger').click
    click_link 'ログアウト'
    expect(current_path).to eq root_path
    # ログイン(二人目)
    sign_in_as user_b
    visit book_path(book)
    # 削除リンクが表示されない
    expect(page).to have_no_link '削除する'
  end

  it 'レビューの編集ができる' do
    sign_in_as user_b

    visit edit_book_review_path(book, review)
    expect(current_path).to eq edit_book_review_path(book, review)

    page.all('#star img')[1].click
    fill_in 'review[title]', with: '変更'
    fill_in 'review[body]', with: '変更しました'
    click_on '評価'

    expect(current_path).to eq book_path(book)
    expect(page).to have_content '変更'
    expect(page).to have_content '変更しました'
  end
end
