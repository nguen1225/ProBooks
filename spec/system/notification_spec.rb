require 'rails_helper'

RSpec.describe '通知機能', type: :system, js: true do
  include LoginSupport

  # レビュー及び拍手される側
  let(:user_a) { create(:user, name: '送られるユーザ') }
  # レビュー及び拍手をする側
  let(:user_b) { create(:user, name: '送るユーザ') }
  let(:category_html) { create(:category, name: 'html&css') }
  let!(:book) { create(:book, user: user_a, category: category_html) }

  describe 'レビューの通知' do
    before do
      sign_in_as user_b
      visit book_path(book)
    end
    context '投稿した書籍にレビューか投稿された場合' do
      it '書籍を投稿した相手に通知が追加される' do
        find('.modal-trigger').click
        # レビューの投稿
        expect do
          page.all('#star img')[1].click
          fill_in 'タイトル', with: '評価1'
          fill_in '内容', with: 'テスト内容'
          click_on '評価する'
          sleep 1.0
        end.to change { Review.count }.by(1)

        expect(page).to have_content '評価1'
        # ログアウトして送られるユーザでログイン
        find('.sidenav-trigger').click
        click_on 'ログアウト'

        sign_in_as user_a
        find('.sidenav-trigger').click
        # 通知アイコン表示のチェック
        expect(page).to have_css '.fa-circle'

        click_on '通知'
        expect(page).to have_content '送るユーザさんがあなたの登録した書籍にレビューしました'
        expect(page).to have_link 'あなたの登録した書籍'
      end
    end
  end
end
