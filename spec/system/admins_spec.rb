require 'rails_helper'

RSpec.describe '管理者機能', type: :system, js: true do
	include LoginSupport
	let!(:admin) { FactoryBot.create :admin }


	describe '管理者用書籍一覧ページ' do
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
			expect(download_content).to include("id,title,content,category_id,level,volume,created_at,updated_at,user_id")
		end
	end

	describe '管理者用会員一覧ページ' do
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
			expect(download_content).to include("id,name,email,status,created_at,updated_at,deleted_at,uid,provider")
		end
	end
end