require 'rails_helper'

RSpec.describe '書籍管理機能', type: :system, js: true do
  let(:admin) { create :admin }
  let(:user_a) { create :user }
  let(:user_b) { create :user }
  let!(:category) { create :category }
  let!(:book_a) { create :book, category: category, user: user_a }

  describe '詳細画面' do
    context '書籍を投稿したユーザーの場合' do
      before do
        sign_in_as(user_a)
        visit book_path(book_a)
      end
      it '編集リンクが表示されている' do
        expect(page).to have_link '編集', href: edit_book_path(book_a)
      end
      it '削除リンク表示されていること' do
        expect(page).to have_link '削除', href: book_path(book_a)
      end
      it '自分名前が表示されていること' do
        expect(page).to have_content "#{user_a.name}さんが投稿"
      end
    end
    context '投稿者でない場合' do
      before do
        sign_in_as(user_b)
        visit book_path(book_a)
      end
      it '編集リンクが表示されない' do
        expect(page).to have_no_link '編集', href: edit_book_path(book_a)
      end
      it '削除リンクが表示されない' do
        expect(page).to have_no_link '削除', href: book_path(book_a)
      end
    end
    context 'ログインしていない場合' do
      it '編集リンクが表示されない' do
        visit book_path(book_a)
        expect(page).to have_no_link "編集", href: edit_book_path(book_a)
      end
      it '削除リンクが表示されない' do
        visit book_path(book_a)
        expect(page).to have_no_link '削除', href: book_path(book_a)
      end
    end
    context '管理ユーザーの場合' do
      before do
        sign_in_as_admin(admin)
        visit book_path(book_a)
      end
      it '編集ページが表示されない' do
        expect(page).to have_no_link '編集', href: edit_book_path(book_a)
      end
      it '削除リンクが表示されない' do
        expect(page).to have_no_link '削除', href: book_path(book_a)
      end
    end
  end
  describe '編集画面' do
    context '投稿したユーザの場合' do
      before do
        sign_in_as(user_a)
        visit edit_book_path(book_a)
      end
      it 'タイトルが表示されている' do
        expect(page).to have_field "book[title]", with: book_a.title
      end
      it '内容が表示されている' do
        expect(page).to have_field "book[content]", with: book_a.content
      end
      it 'カテゴリが選択されている' do
        expect(all('.input-text input')[1].value).to eq category.name
      end
      it '難易度が選択されている' do
        expect(all('.input-text input')[2].value).to eq book_a.level.text
      end
      it 'ボリュームが選択されている' do
        expect(all('.input-text input')[3].value).to eq book_a.volume.text
      end
    end
    context 'ログインしていない場合' do
      it 'リダイレクトされる' do
        visit edit_book_path(book_a)
        expect(current_path).to eq new_user_session_path
      end
      it 'フラッシュメッセージが表示される' do
        visit edit_book_path(book_a)
        expect(page).to have_content "アカウント登録もしくはログインしてください。"
      end
    end
    context '管理者の場合' do
      before do
        sign_in_as_admin(admin)
        visit edit_book_path(book_a)
      end
      it 'リダイレクトする' do
        expect(current_path).to eq new_user_session_path
      end
      it 'フラッシュメッセージが表示される' do
        expect(page).to have_content 'アカウント登録もしくはログインしてください。'
      end
    end
  end
end
