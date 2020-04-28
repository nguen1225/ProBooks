require 'rails_helper'

RSpec.describe 'レビュー画面機能', type: :system, js: true do
  include LoginSupport
  let!(:user_a) { create :user } # レビュー投稿ユーザ
  let!(:user_b) { create :user } # 書籍投稿ユーザ
  let!(:user_c) { create :user } # ただのユーザ
  let(:admin) { create :admin }
  let!(:book) { create :book, user: user_b }
  let!(:review) { create :review, user: user_a, book: book }

  describe '一覧画面' do
    context 'レビューを投稿したユーザの場合' do
      before do
        sign_in_as(user_a)
        visit book_path(book)
      end
      it '編集リンクが表示される' do
        expect(page).to have_link '編集', href: edit_book_review_path(review, book)
      end
      it '削除リンクが表示される' do
        expect(page).to have_link '削除', href: book_review_path(review, book)
      end
      it '拍手ボタンが表示されない' do
        expect(page).to have_no_css '.fa-sign-language'
      end
    end
    context 'ログインしているユーザの場合' do
      before do
        sign_in_as(user_c)
        visit book_path(book)
      end
      it '編集リンクが表示されない' do
        expect(page).to have_no_link '編集', href: edit_book_review_path(review, book)
      end
      it '削除リンクが表示されない' do
        expect(page).to have_no_link '削除', href: book_review_path(review, book)
      end
      it '拍手ボタンが表示される' do
        expect(page).to have_css '.fa-sign-language'
      end
    end
    context '管理ユーザの場合' do
      before do
        sign_in_as_admin(admin)
        visit book_path(book)
      end
      it '編集リンクが表示されない' do
        expect(page).to have_no_link '編集', href: edit_book_review_path(review, book)
      end
      it '削除リンクが表示されない' do
        expect(page).to have_no_link '削除', href: book_review_path(review, book)
      end
      it '拍手ボタンが表示されない' do
        expect(page).to have_no_css '.fa-sign-language'
      end
    end
  end
  describe '編集画面' do
    context 'レビューを投稿したユーザの場合' do
      before do
        sign_in_as(user_a)
        visit edit_book_review_path(review, book)
      end
      it 'タイトルが表示されている' do
        expect(page).to have_field 'review[title]', with: review.title
      end
      it '内容が表示されている' do
        expect(page).to have_field 'review[body]', with: review.body
      end
    end
  end
end
