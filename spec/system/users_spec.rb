require 'rails_helper'

RSpec.describe 'ユーザー管理機能', type: :system, js: true do
	let!(:user_a) { create :user }
	let(:user_b) { create :user }
	describe 'ユーザ編集機能' do
		context 'ログインしている場合' do
			before do
				sign_in_as user_a
				visit edit_user_path(user_a)
			end
			it '名前が正しく表示されている' do
				expect(page).to have_field "user[name]", with: user_a.name
			end
			it 'メールアドレスが正しく表示されている' do
				expect(page).to have_field "user[email]", with: user_a.email
			end
			it '自己紹介が正しく表示されている' do
				expect(page).to have_field "user[introduction]", with: user_a.introduction
			end
		end
		context 'ログインしてない場合' do
			it 'ログインページへリダイレクトする' do
				visit edit_user_path(user_a)
				expect(current_path).to eq new_user_session_path
			end
			it 'フラッシュメッセージが表示される' do
				visit edit_user_path(user_a)
				expect(page).to have_content 'ログインしてください。'
			end
		end
		context '一致しないユーザである場合' do
			before do
				sign_in_as user_b
				visit edit_user_path(user_a)
			end
			it 'リダイレクトする' do
				expect(current_path).to eq new_user_session_path
			end
			it 'フラッシュメッセージが表示される' do
				expect(page).to have_content '正しいユーザではありません'
			end
		end
	end
	describe 'ユーザ詳細ページ', must: true do
		context 'ログインしている場合' do
			before do
				sign_in_as(user_a)
				visit user_path(user_a)
			end
			it '自分の名前が表示されている' do
				expect(page).to have_content(user_a.name)
			end
			it '自分のレベルが表示されている' do
				expect(page).to have_content(user_a.level)
			end
			it 'プロフィール編集リンクが表示されている' do
				expect(page).to have_link "編集", href: edit_user_path(user_a)
			end
		end
		context 'ログインしてない場合' do
			it '編集リンクが表示されない' do
				expect(page).to have_no_link "編集"
			end
		end
		context '一致しないユーザである場合' do
			it '編集リンクが表示されない' do
				expect(page).to have_no_link "編集"
			end
		end
	end
end