require 'rails_helper'

RSpec.describe '参考になったボタン機能', type: :system, js: true do
  include LoginSupport

  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:book) { create(:book, user: user, category: category) }
  let!(:review) { create(:review, user: user, book: book) }
  let!(:level_standard) { create(:level_standard) }

  describe 'ログインしたユーザー' do
    # ログインして書籍詳細ページへ遷移
    before do
      sign_in_as user
      visit book_path(book)
    end

    context '拍手アイコンをクリックした場合' do
      it 'カウントが１増える' do
        expect do
          find('.clapping').click
          sleep 1.0
          expect(page).to have_content '1'
        end.to change { Clap.count }.by(1)
      end
    end

    context '取り消すボタンをクリックした場合' do
      it 'カウントが１減る' do
        expect do
          find('.clapping').click
          sleep 0.5
        end.to change { Clap.count }.by(1)
        expect do
          find('.not-clapping').click
          expect(page).to have_content '0'
          sleep 0.5
        end.to change { Clap.count }.by(-1)
      end
    end
  end

  # describe 'ログインしてないユーザー' do
  #   before do
  #     visit book_path(@book)
  #   end
  #   it 'ボタンをクリック後ログインページへ遷移' do
  #   end

  #   it 'ボタンをクリックしたユーザ一覧が表示' do
  #   end
  # end
end
