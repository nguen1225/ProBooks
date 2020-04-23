require 'rails_helper'

RSpec.describe BooksController, type: :request do
  include LoginSupport
  let(:user_a) { FactoryBot.create :user_a}
  let!(:book_a) { FactoryBot.create(:book, title: "ももクロ伝記", user: user_a) }
  let!(:book_b) { FactoryBot.create(:book, title: "ももクロ伝説", user: user_a) }

  before do
    request_login user_a
  end

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
    # context '不正なパラメータの場合', must: true do
    #   it 'リクエストが成功すること' do
    #     post books_url, params: { book: FactoryBot.attributes_for(:book_c, :invalid) }
    #     expect(response.status).to eq 200
    #   end
    #   it '書籍が登録されない' do
    #     expect {
    #       post books_url, params: { book: FactoryBot.attributes_for(:book_c, :invalid) }
    #     }.to_not change(User, :count)
    #   end
    #   it 'エラーが表示されること' do
    #     post books_url, params: { book: FactoryBot.attributes_for(:book_c, :invalid) }
    #     expect(response.body).to include 'タイトルを入力してください'
    #   end
    # end
  end
  describe 'GET #show' do
    context '書籍が存在する場合' do
      it 'リクエストが成功すること' do
        get book_url book_a
        expect(response.status).to eq 200
      end
      it 'タイトルが表示されていること' do
        get book_url book_a
        exppect(response.body).to include book.title
      end
      it '内容が表示されていること' do
        get book_url book_a
        expect(response.body).to include book.content
      end
    end
    context '書籍が存在しない場合' do
      subject { -> { get book_url 1 } }
      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end
end


#   context 'ユーザーが存在しない場合' do
#     subject { -> { get user_url 1 } }

#     it { is_expected.to raise_error ActiveRecord::RecordNotFound }
#   end
# end