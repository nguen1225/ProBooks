require 'rails_helper'

RSpec.describe 'User認証機能', type: :system, js: true do
  include LoginSupport
  let(:user_a) { FactoryBot.create(:user) }
  let(:user_b) { FactoryBot.create(:user) }

  describe 'Function' do
    before do
      visit root_path
    end

    describe '登録' do
      it '新規登録できる' do
        click_on 'Sign Up'
        expect(current_path).to eq new_user_registration_path
        expect {
          fill_in  '名前', with: 'テスト'
          fill_in  'メールアドレス', with: 'test@example.com'
          fill_in  'パスワード', with: 'foobar'
          fill_in  'パスワード（確認用）', with: 'foobar'
          click_on '登録'
        }.to change{User.count}.by(1)

        expect(page).to have_content 'アカウント登録が完了しました'
        expect(page).to have_content 'テスト'
      end
    end

    describe '編集/更新' do
      before do
        sign_in_as user_a
      end

      it 'ユーザー情報を更新できる' do
        visit edit_user_path(user_a)
        fill_in '名前', with: '更新太郎'
        fill_in 'メールアドレス', with: 'update@example.com'
        fill_in '自己紹介', with: 'よろしくお願いします'
        find(".dropdown-trigger").click
        find("li", text: "Begineer").click
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
        expect(page).to have_no_link '編集'
      end
    end

    describe 'ログイン機能'  do
      #ユーザー作成
      before do
        visit new_user_session_path
        fill_in  'メールアドレス', with: user_a.email
        fill_in  'パスワード', with: user_a.password
        click_on 'Log In'
      end

      it 'ログインができる' do
        expect(page).to have_content 'ログインしました'
      end

      it 'ヘッダーレイアウトが変更' do
        find('.sidenav-trigger').click
        expect(page).to have_content '書籍の投稿'
        expect(page).to have_content '書籍を探す'
        expect(page).to have_content 'マイページ'
        expect(page).to have_content '通知'
        expect(page).to have_content 'ユーザーレベル'
        expect(page).to have_content 'ログアウト'
      end
    end
  end

  describe 'view' do
    before do
      visit new_user_registration_path
    end

    it '新規登録後ヘッダー画面が変更すること' do
      fill_in '名前', with: 'テスト'
      fill_in  'メールアドレス', with: 'test@example.com'
      fill_in  'パスワード', with: 'foobar'
      fill_in  'パスワード（確認用）', with: 'foobar'
      click_on '登録'

      expect(page).to have_content 'アカウント登録が完了しました'

      find('.sidenav-trigger').click
      expect(page).to have_content '書籍の投稿'
      expect(page).to have_content '書籍を探す'
      expect(page).to have_content 'マイページ'
      expect(page).to have_content '通知'
      expect(page).to have_content 'ユーザーレベル'
      expect(page).to have_content 'ログアウト'
    end

    it 'ログイン後ヘッダーレイアウトが変更すること' do
      sign_in_as user_a
      expect(page).to have_content 'ログインしました'

      find('.sidenav-trigger').click
      expect(page).to have_content '書籍の投稿'
      expect(page).to have_content '書籍を探す'
      expect(page).to have_content 'マイページ'
      expect(page).to have_content '通知'
      expect(page).to have_content 'ユーザーレベル'
      expect(page).to have_content 'ログアウト'
    end
  end
end
