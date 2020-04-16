require 'rails_helper'

RSpec.describe '参考になったボタン機能', type: :system do
  include LoginSupport

  before do
    @user = FactoryBot.create(:user)
    @book = FactoryBot.create(:book, user: @user)
    @review = FactoryBot.create(:review, user: @user, book: @book)
  end

  describe 'ログインしたユーザー' do
    # ログインして書籍詳細ページへ遷移
    before do
      sign_in_as @user
      visit book_path(@book)
    end

    context 'ボタンをクリックすると' do
      it 'カウントが１増える' do
        expect do
          click_on '参考になった'
        end.to change(@review.claps, :count).by(1)
      end
    end

    context '取り消すボタンをクリックした場合' do
      it 'カウントが１減る' do
        click_on '参考になった'
        expect(page).to have_link '取り消す'
        expect do
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
