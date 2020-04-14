require 'rails_helper'

RSpec.describe 'レビュー機能', type: :system do
  include LoginSupport

  before do
    @user_a = FactoryBot.create(:user, email: 'user_a@example.com')
    @book = FactoryBot.create(:book, user: @user_a)
  end

  it 'レビューを投稿できる' do
    # ログインしてレビューを投稿
    sign_in_as @user_a
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
    user_b = FactoryBot.create(:user,
                               email: 'user2@email.com',
                               uid: 'hogehoeg')
    # ログイン（一人目）
    sign_in_as @user_a
    # レビューの投稿 -> レビューカウントが増える
    visit book_path(@book)
    expect do
      fill_in 'タイトル', with: '評価１'
      fill_in '内容', with: 'テスト内容'
      fill_in '評価', with: 1
      click_button '評価する'
    end.to change(@book.reviews, :count).by(1)
    # ログアウト
    click_link 'ログアウト'
    expect(current_path).to eq root_path
    # ログイン(二人目)
    sign_in_as user_b
    visit book_path(@book)
    # #削除ができない
    expect(page).to have_no_link '削除する'
  end
end
