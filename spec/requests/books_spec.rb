require 'rails_helper'

RSpec.describe BooksController, type: :request do
  let(:user_a) { FactoryBot.create :user_a}
  let(:category) { FactoryBot.create(:category, name: "html") }
  let!(:book_a) { FactoryBot.create(:book, title: "ももクロ伝記", user: user_a, category: category) }
  let!(:book_b) { FactoryBot.create(:book, title: "ももクロ伝説", user: user_a, category: category) }

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
        expect {
          post books_path, params: { book: FactoryBot.attributes_for(:book_c) }
        }.to change(Book, :count).by(1)
      end
      it 'リダイレクトすること' do
        post books_url, params: { book: FactoryBot.attributes_for(:book_c) }
        expect(response).to redirect_to Book.last
      end
    end
  #   context '不正なパラメータの場合', must: true do
  #     it 'リクエストが成功すること' do
  #       book_params = FactoryBot.attributes_for(:book, :invalid)
  #       expect {
  #         post books_url, params: { book: book_params }
  #       }.to_not change(Book, :count)
  #     end
  #     it '書籍が登録されない' do
  #       expect {
  #         post books_url, params: { book: FactoryBot.attributes_for(:book, :invalid) }
  #       }.to_not change(Book, :count)
  #     end
  #     it 'エラーが表示されること' do
  #       post books_url, params: { book: FactoryBot.attributes_for(:book, :invalid) }
  #       expect(response.body).to include 'タイトルを入力してください'
  #     end
  #   end
  end
  describe 'GET #show' do
    context '書籍が存在する場合' do
      it 'リクエストが成功すること' do
        get book_url book_a
        expect(response.status).to eq 200
      end
      it 'タイトルが表示されていること' do
        get book_url book_a
        expect(response.body).to include book_a.title
      end
      it '内容が表示されていること' do
        get book_url book_a
        expect(response.body).to include book_a.content
      end
      it 'カテゴリが表示されていること' do
        get book_url book_a
        expect(response.body).to include book_a.category.name
      end
      it 'レベルが表示されていること' do
        get book_url book_a
        expect(response.body).to include book_a.level
      end
      it 'ボリュームが表示されていること' do
        get book_url book_a
        expect(response.body).to include book_a.volume
      end
    end
  end

  describe 'GET #edit', must: true do
    it 'リクエストが成功すること' do
      get edit_book_url book_a
      expect(response.status).to eq 200
    end

    it 'タイトルが表示されていること' do
      get edit_book_url book_a
      expect(response.body).to include book_a.title
    end

    it '内容が表示されていること' do
      get edit_book_url book_a
      expect(response.body).to include book_a.content
    end

    it 'カテゴリが表示されていること' do
      get edit_book_url book_a
      expect(response.body).to include book_a.category.name
    end

    it 'ボリュームが表示されていること' do
      get edit_book_url book_a
      expect(response.body).to include book_a.volume
    end

    it 'レベルが表示されていること' do
      get edit_book_url book_a
      expect(response.body).to include book_a.level
    end
  end
end