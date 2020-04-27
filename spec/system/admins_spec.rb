require 'rails_helper'

RSpec.describe '管理者機能', type: :system, js: true do
  include LoginSupport
  let!(:admin) { create :admin }

  describe '管理者全体' do
    context '有効なユーザである場合' do
      before do
        sign_in_as_admin(admin)
      end
      it 'ダッシュボードへ遷移する' do
        expect(current_path).to eq admins_root_path
      end
      it 'フラッシュメッセージが表示される' do
        expect(page).to have_content 'ログインしました。'
      end
      it 'ヘッダーレイアウトが変更される' do
        find('.sidenav-trigger').click
        expect(page).to have_link '会員一覧', href: admins_users_path
        expect(page).to have_link '書籍一覧', href: admins_books_path
        expect(page).to have_link 'ダッシュボード', href: admins_root_path
        expect(page).to have_link 'カテゴリの追加', href: categories_path
        expect(page).to have_link 'ログアウト', href: destroy_admin_session_path
      end
    end
    context '不正なユーザーである場合' do
      let(:user) { create :user }
      before do
        sign_in_as user
        visit admins_root_path
      end
      it 'ログインページへリダイレクトする' do
        expect(current_path).to eq new_admin_session_path
      end
      it 'フラッシュメッセージが表示される' do
        expect(page).to have_content 'アカウント登録もしくはログインしてください。'
      end
    end
  end

  describe '管理者用書籍一覧ページ' do
    context 'csvファイルのテスト' do
      before do
        sign_in_as_admin(admin)
        visit admins_books_path
      end
      it 'csvファイルをエクスポートできること' do
        click_on 'csvエクスポート'
        expect(download_file_name).to include("登録書籍一覧-#{Time.zone.now.strftime('%Y%m%d')}.csv")
      end
      it 'csvファイルのheaderが正しい内容であること' do
        click_on 'csvエクスポート'
        expect(download_content).to include('id,title,content,category_id,level,volume,created_at,updated_at,user_id')
      end
    end
  end

  describe '管理者用会員一覧ページ' do
    let!(:user) { create :user }
    before do
      sign_in_as_admin(admin)
      visit admins_users_path
    end
    it 'csvファイルをエクスポートできること' do
      click_on 'csvエクスポート'
      expect(download_file_name).to include("登録会員一覧-#{Time.zone.now.strftime('%Y%m%d')}.csv")
    end
    it 'csvファイルのheaderが正しい内容であること' do
      click_on 'csvエクスポート'
      expect(download_content).to include('id,name,email,status,created_at,updated_at,deleted_at,uid,provider')
    end
    it 'ユーザを論理削除できる' do
      click_on '削除'
      expect(page).to have_content '無効'
    end
  end
end
