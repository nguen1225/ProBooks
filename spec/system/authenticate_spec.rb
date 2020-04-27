require 'rails_helper'

RSpec.describe 'User認証機能', type: :system, js: true do
  include LoginSupport
  let(:user_a) { create(:user) }
  let(:user_b) { create(:user) }

  describe 'Function' do
    before do
      visit(root_path)
    end

    describe '登録' do
      it '新規登録できる' do
        click_on 'Sign Up'
        expect(current_path).to eq new_user_registration_path
        expect do
          fill_in  '名前', with: 'テスト'
          fill_in  'メールアドレス', with: 'test@example.com'
          fill_in  'パスワード', with: 'foobar'
          fill_in  'パスワード（確認用）', with: 'foobar'
          click_on '登録'
        end.to change { User.count }.by(1)

        expect(page).to have_content 'アカウント登録が完了しました'
        expect(page).to have_content 'テスト'
      end
    end

    describe '編集/更新' do
      before do
        sign_in_as(user_a)
      end

      it 'ユーザー情報を更新できる' do
        visit edit_user_path(user_a)
        fill_in '名前', with: '更新太郎'
        fill_in 'メールアドレス', with: 'update@example.com'
        fill_in '自己紹介', with: 'よろしくお願いします'
        find('.dropdown-trigger').click
        find('li', text: 'Begineer').click
        click_on '更新'

        expect(current_path).to eq user_path(user_a)
        expect(page).to have_content '更新しました'
        expect(page).to have_content '更新太郎'
        expect(page).to have_content 'よろしくお願いします'
        expect(page).to have_content 'begineer'
      end

      it '他のユーザーの情報を更新できない' do
        visit root_path
        find('.sidenav-trigger').click
        click_on 'ログアウト'
        # 二人目のユーザーでログイン
        sign_in_as user_b
        # 一人目のユーザー詳細ページへ
        visit user_path(user_a)
        # 編集リンクが表示されないことを確認
        expect(page).to have_no_link '編集', href: user_path(user_a)
      end
    end
  end

  describe 'レイアウトの変更', must: true do
    shared_examples_for 'ヘッダーリストの変更' do
      it {
        find('.sidenav-trigger').click
        expect(page).to have_link '書籍の投稿', href: new_book_path
        expect(page).to have_link '書籍を探す', href: books_path
        expect(page).to have_link 'マイページ'
        expect(page).to have_link '通知', href: notifications_path
        expect(page).to have_content 'ユーザーレベル'
        expect(page).to have_link 'ログアウト', href: destroy_user_session_path
      }
    end
    context '新規登録した場合' do
      before do
        visit new_user_registration_path
        fill_in '名前', with: 'テスト'
        fill_in  'メールアドレス', with: 'test@example.com'
        fill_in  'パスワード', with: 'foobar'
        fill_in  'パスワード（確認用）', with: 'foobar'
        click_on '登録'
      end
      it_behaves_like 'ヘッダーリストの変更'
    end
    context 'ログインした場合' do
      before do
        sign_in_as user_a
      end
      it_behaves_like 'ヘッダーリストの変更'
    end
  end
end
