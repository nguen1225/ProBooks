require 'rails_helper'

RSpec.describe '参考になったボタン機能', type: :system do
  include LoginSupport

  before do
    @user = FactoryBot.create(:user)
    category = FactoryBot.create(:category)
    @book = FactoryBot.create(:book, user_id: @user.id, category_id: category.id )
    @review = FactoryBot.create(:review, user_id: @user.id, book_id: @book.id)
  end

  describe 'ログインしたユーザー' do
    # ログインして書籍詳細ページへ遷移
    before do
      sign_in_as @user
      visit book_path(@book)
    end

    context 'ボタンをクリックすると' do
      it 'カウントが１増える', js: true,must: true  do
        # expect {
        all('.review-content a')[1].click
        expect(page).to have_content "1"
        # }.to change(Clap, :count).by(1)
      end
    end

    context '取り消すボタンをクリックした場合' do
      it 'カウントが１減る', js: true do
        expect {
          all('.review-content a')[1].click
        }.
        expect do
          all('.review-content a')[1].click
          click_on '取り消す'
        end.to change(@review.claps, :count).by(-1)
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
