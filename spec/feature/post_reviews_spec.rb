require 'rails_helper'

RSpec.feature 'レビュー機能', type: :feature do
  include LoginSupport

  background do
    @user = FactoryBot.create(:user)
    @book = FactoryBot.create(:book, user: @user)
  end

  scenario 'レビューを投稿できる' do
    # ログインしてレビューを投稿
    sign_in_as @user
    visit book_path(@book)

    expect do
      fill_in 'タイトル', with: '評価１'
      fill_in '内容', with: 'テスト内容'
      fill_in '評価', with: 1
      click_button '評価する'
    end.to change(@book.reviews, :count).by(1)

    # 投稿した内容が表示される
    expect(page).to have_content '投稿しました'
    expect(page).to have_content '評価１'
    expect(page).to have_content 'テスト内容'
    expect(page).to have_link '削除'

    expect do
      click_link '削除'
    end.to change(@book.reviews, :count).by(-1)

    # 削除したレビューが表示されない
    expect(page).to have_no_content '評価１'
    expect(page).to have_no_content 'テスト内容'
  end

  it '自分の投稿したレビュー以外削除できない' do
  end
end
