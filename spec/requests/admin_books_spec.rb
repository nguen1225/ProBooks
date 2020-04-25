require 'rails_helper'

RSpec.describe "AdminBooks", type: :request do
  describe "GET #index" do
    let(:admin_user) { FactoryBot.create :admin}
    let!(:book_a) { FactoryBot.create :book }

    context '管理者である場合' do
      before do
          sign_in admin_user
      end
      it 'リクエストが成功すること' do
        get admins_books_url
        expect(response.status).to eq 200
      end
      it '書籍名が表示されていること' do
        get admins_books_url
        expect(response.body).to include book_a.title
      end
      it '難易度が表示されていること' do
        get admins_books_url
        expect(response.body).to include book_a.level
      end
    end
    context '管理者でない場合' do
      it "リダイレクトすること" do
        get admins_books_url
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end
end
