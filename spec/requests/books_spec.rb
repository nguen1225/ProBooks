require 'rails_helper'

RSpec.describe BooksController, type: :request do
  let(:user_a) { create(:user_a) }
  let(:category) { create(:category, name: 'html') }
  let!(:book_a) { create(:book) }
  let!(:book_b) { create(:book) }

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
    # context '正常なパラメータの場合' do
    #   # it 'リクエストが成功すること', must: true  do
    #   #   post books_url, params: { book: attributes_for(:book_c, user: user_a) }
    #   #   expect(response.status).to eq 302
    #   # end
    #   # it '書籍が登録されること' do
    #   #   book_params = attributes_for(:book_c)
    #   #   expect do
    #   #     post books_url, params: { book: book_params }
    #   #   end.to change{ Book.count }.by(1)
    #   # end
    #   # it 'リダイレクトすること' do
    #   #   post books_url, params: { book: attributes_for(:book_c) }
    #   #   expect(response).to redirect_to book_url
    #   # end
    # end
    context '不正なパラメータの場合' do
      it 'リクエストが成功すること' do
        post books_url, params: { book: attributes_for(:book_c, :invalid) }
        expect(response.status).to eq 200
      end
    end
  end
end
