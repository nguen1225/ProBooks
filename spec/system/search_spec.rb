require 'rails_helper'

RSpec.describe '検索機能', type: :system do
	include LoginSupport
	let(:user) { FactoryBot.create(:user) }
	let(:category_html) { FactoryBot.create(:category, name: "html&css") }
	let(:category_javascript) { FactoryBot.create(:category, name: "javascript") }
	let(:category_ruby) { FactoryBot.create(:category, name: "ruby") }
	let!(:book_first) { FactoryBot.create(:book,  title: "テスト駆動開発1",  level: "easy", volume: "few" , category: category_html, user: user) }
	let!(:book_second) { FactoryBot.create(:book, title: "テスト駆動開発2",  level: "normal", volume: "medium" , category: category_javascript, user: user) }
	let!(:book_third) { FactoryBot.create(:book,  title: "テスト駆動開発3",  level: "hard", volume: "many" , category: category_ruby, user: user) }

	before do
		sign_in_as user
		visit books_path
	end

	context 'キーワード検索', js: true do
		it '入力したタイトルの書籍のみが表示される' do
			fill_in 'タイトル', with: "テスト駆動開発1"
			click_button '検索'
			expect(page).to have_content 'テスト駆動開発1'
			expect(page).to have_no_content 'テスト駆動開発2'
		end
		it '選択したカテゴリの書籍のみが表示される' do
			all('form input')[1].click
			find("li", text: "ruby").click
			click_on '検索'

			expect(page).to have_content 'テスト駆動開発3'
			expect(page).to have_no_content 'テスト駆動開発2'
		end
		it '選択したボリュームの書籍のみが表示される' do
			all('form input')[2].click
			find("li", text: "many").click
			click_on '検索'

			expect(page).to have_content 'テスト駆動開発3'
			expect(page).to have_no_content 'テスト駆動開発2'
		end
		it '選択した難易度の書籍のみが表示される' do
			all('form input')[3].click
			find("li", text: "easy").click
			click_on '検索'
			expect(page).to have_content 'テスト駆動開発1'
			expect(page).to have_no_content "テスト駆動開発2"
		end
	end

	context 'タグ検索', js: true do
		before do
			visit new_book_path
			fill_in 'タイトル', with: 'タグテスト'
			fill_in '内容', with: 'テストしました'
			all('.input-text input')[1].click
			find("li", text: "html&css").click
			fill_in 'タグ', with: '#テストタグ'
			click_on '登録'
		end

		it '選択したタグに紐付く書籍のみが表示される' do
			visit books_path
			click_on 'タグ検索'
			click_on '#テストタグ'
			expect(page).to have_content 'タグテスト'
			expect(page).to have_link '詳細'
		end
	end

	context '言語検索', js: true  do
		it 'HTMLの書籍が表示される' do
			click_on "HTML&CSS"
			expect(page).to have_content 'テスト駆動開発1'
			expect(page).to have_link '詳細'
		end

		it 'Javascriptの書籍が表示される' do
			click_on "Javascript"
			expect(page).to have_content 'テスト駆動開発2'
			expect(page).to have_link '詳細'
		end

		it 'Rubyの書籍が表示される' do
			click_on "Ruby"
			expect(page).to have_content 'テスト駆動開発3'
			expect(page).to have_link '詳細'
		end
	end
end