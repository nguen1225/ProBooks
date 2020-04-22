require 'rails_helper'

RSpec.describe 'お気に入り機能', type: :system do
	include LoginSupport
	let(:user) { FactoryBot.create(:user) }
	let(:category_html) { FactoryBot.create(:category, name: "html&css") }
	let(:category_javascript) { FactoryBot.create(:category, name: "javascript") }
	let!(:book_first) { FactoryBot.create(:book,  title: "テスト駆動開発1", level: "easy", volume: "few" , category: category_html, user: user) }
	let!(:book_second) { FactoryBot.create(:book, title: "テスト駆動開発2", level: "normal", volume: "medium" , category: category_javascript, user: user) }

	before do
		sign_in_as user
	end

	it 'お気に入りボタンの表示が変更', js: true do
		visit book_path(book_first)
		click_on 'お気に入りに追加'
		expect(page).to have_content 'お気に入りから外す'
	end

	it 'お気に入り登録後マイページに追加されている', js: true do
		visit book_path(book_first)
		click_on 'お気に入りに追加'
		visit book_path(book_second)
		click_on 'お気に入りに追加'
		visit user_path(user)
		expect(page).to have_content 'テスト駆動開発1'
		expect(page).to have_content 'テスト駆動開発2'
	end

end