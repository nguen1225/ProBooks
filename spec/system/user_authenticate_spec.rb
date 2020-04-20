require 'rails_helper'

RSpec.describe 'User', type: :system do
  include LoginSupport
  describe '機能' do
    before do
      visit root_path
    end

    describe 'ユーザー登録' do
      it '新規登録できる' do
        click_on 'Sign Up'
        expect(current_path).to eq new_user_registration_path

        fill_in  '名前', with: 'テスト'
        fill_in  'メールアドレス', with: 'test@example.com'
        fill_in  'パスワード', with: 'foobar'
        fill_in  'パスワード（確認用）', with: 'foobar'
        click_on '登録'

        expect(page).to have_content 'アカウント登録が完了しました'
        expect(page).to have_content 'テスト'
        expect(page).to have_content 'test@example.com'
      end
    end

    describe 'ユーザ編集・詳細' do
      before do
        @user = FactoryBot.create(:user)
        sign_in_as @user
      end

      it 'ユーザー情報を更新できる' do
        visit edit_user_path(@user)
        fill_in '名前', with: '更新太郎'
        fill_in 'メールアドレス', with: 'update@example.com'
        fill_in '自己紹介', with: 'よろしくお願いします'
        select 'Engineer', from: 'ステータス'
        click_on '更新'

        expect(current_path).to eq user_path(@user)
        expect(page).to have_content '更新しました'
        expect(page).to have_content '更新太郎'
        expect(page).to have_content 'よろしくお願いします'
        expect(page).to have_content 'engineer'
      end

      it '他のユーザーの情報を更新できない' do
        user_b = FactoryBot.create(:user,
                                   email: 'user2@email.com',
                                   uid: 'hogehoge')
        visit root_path
        click_on 'ログアウト'
        # 二人目のユーザーでログイン
        sign_in_as user_b
        # 一人目のユーザー詳細ページへ
        visit user_path(@user)
        # 編集リンクが表示されないことを確認
        expect(page).to have_no_link '編集'
      end
    end
  end

  describe 'レイアウト' do
    before do
      visit new_user_registration_path
    end

    it '新規登録後ヘッダー画面が変更' do
      fill_in '名前', with: 'テスト'
      fill_in  'メールアドレス', with: 'test@example.com'
      fill_in  'パスワード', with: 'foobar'
      fill_in  'パスワード（確認用）', with: 'foobar'
      click_on '登録'

      expect(current_path).to eq root_path
      expect(page).to have_content '書籍の投稿'
      expect(page).to have_content '書籍を探す'
      expect(page).to have_content 'マイページ'
      expect(page).to have_content '通知'
      expect(page).to have_content 'ユーザーレベル'
      expect(page).to have_content 'ログアウト'
    end
  end
end
