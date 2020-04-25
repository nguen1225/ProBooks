require 'rails_helper'

RSpec.describe BooksController, type: :request do
  let(:user_a) { FactoryBot.create(:user_a) }
  let(:category) { FactoryBot.create(:category, name: 'html') }
  let!(:book_a) { FactoryBot.create(:book) }
  let!(:book_b) { FactoryBot.create(:book) }

  describe 'GET #index' do
    it 'リクエストが成功すること' do
      get books_url
      expect(response.status).to eq 200
    end

    it '書籍名が表示されていること' do
      get books_url
      expect(response.body).to include book_a.title
      expect(response.body).to include book_b.title
    end
  end

  describe 'POST #create' do
    context '正常なパラメータの場合' do
      it 'リクエストが成功すること' do
        post books_url, params: { book: FactoryBot.attributes_for(:book_c) }
        expect(response.status).to eq 302
      end
      it '書籍が登録されること' do
        book_params = FactoryBot.attributes_for(:book_c)
        sign_in user_a
        expect {
          post books_url, params: { book: book_params }
        }.to change(Book, :count).by(1)
      end
      it 'リダイレクトすること' do
        post books_url, params: { book: FactoryBot.attributes_for(:book_c) }
        expect(response).to redirect_to Book.last
      end
    end
  end
end