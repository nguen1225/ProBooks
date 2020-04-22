require 'rails_helper'

RSpec.describe 'レベルアップ機能', type: :system, js: true do
	include LoginSupport
	#拍手をされてレベルアップする側
	let!(:level_standard) { FactoryBot.create(:level_standard) }
	let(:category) { FactoryBot.create(:category) }
	let(:user_a) { FactoryBot.create(:user) }
	let!(:book) { FactoryBot.create(:book, category: category, user: user_a) }
	let!(:review) { FactoryBot.create(:review, book: book, user: user_a) }
	#拍手を送る側ユーザーら
	let(:user_b) { FactoryBot.create(:user) }
	let(:user_c) { FactoryBot.create(:user) }
	let(:user_d) { FactoryBot.create(:user) }

	it '拍手を３回もらうとレベルが１上がる' do
		#ユーザーレベルの確認
		sign_in_as user_a
		find('.sidenav-trigger').click
		expect(page).to have_content 'Lv.1'
		click_link 'ログアウト'

		#ユーザBでログインしてユーザAのレビューに対して拍手
		sign_in_as user_b
		visit book_path(book)
		expect {
			find('.clapping').click
			sleep 0.5
		}.to change{ Clap.count }.by(1)
		#ユーザBのログアウト
		find('.sidenav-trigger').click
		click_link 'ログアウト'

		#ユーザcでログイン
		sign_in_as user_c
		visit book_path(book)
		expect {
			find('.clapping').click
			sleep 0.5
		}.to change{ Clap.count }.by(1)
		#ユーザBのログアウト
		find('.sidenav-trigger').click
		click_link 'ログアウト'

		#ユーザdでログイン
		sign_in_as user_d
		visit book_path(book)
		expect {
			find('.clapping').click
			sleep 0.5
		}.to change{ Clap.count }.by(1)
		#ユーザBのログアウト
		find('.sidenav-trigger').click
		click_link 'ログアウト'

		#ユーザAでログインとレベルアップの確認
		sign_in_as user_a
		find('.sidenav-trigger').click
		expect(page).to have_content 'Lv.2'
	end
end