require 'rails_helper'

RSpec.feature 'Book Tag UI', type: :feature do
	background do
		@user = FactoryBot.create(:user)
		visit new_user_session_path
		fill_in  'メールアドレス', with: 'test@example.com'
		fill_in  'パスワード', with: 'foobar'
		click_on 'Log In'
	end

	scenario '本にタグを紐付けることができる' do
		#書籍の登録
		visit new_book_path
		fill_in 'Title', with: 'タイトル'
		fill_in 'Content', with: 'コンテント'
		select 'Html', from: 'Category'
		fill_in 'Tag list', with: '#テストタグ'
		click_on 'Create Book'

		#登録した情報が反映されている
		expect(page).to have_content 'タイトル'
		expect(page).to have_content 'コンテント'
		expect(page).to have_content 'html'
		expect(page).to have_content '#テストタグ'

		#タグをクリック
		click_link '#テストタグ'
		expect(page).to have_content 'タイトル'
	end


	scenario '同じタグの書籍が複数表示される' do
		#書籍の登録(１冊目)
		visit new_book_path
		fill_in 'Title', with: 'first'
		fill_in 'Content', with: 'one content'
		select 'Html', from: 'Category'
		fill_in 'Tag list', with: '#テストタグ'
		click_on 'Create Book'

		expect(page).to have_content 'first'
		expect(page).to have_content 'one content'
		expect(page).to have_content 'html'
		expect(page).to have_content '#テストタグ'
		click_link '本投稿'

		#書籍の登録（２冊目）
		fill_in 'Title', with: 'second'
		fill_in 'Content', with: 'tow content'
		select 'Html', from: 'Category'
		fill_in 'Tag list', with: '#テストタグ'
		click_on 'Create Book'

		expect(page).to have_content '#テストタグ'
		click_link '#テストタグ'

		#firstとsecondの書籍が同じタグで表示されている
		expect(page).to have_content 'first'
		expect(page).to have_content 'second'
	end
end