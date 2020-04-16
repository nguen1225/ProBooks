require 'rails_helper'

RSpec.describe 'TopPage', type: :system do
  before do
    visit root_path
  end

  it '新規登録リンクをクリックするとリンクへ遷移する' do
    click_link '新規登録'
    expect(current_path).to eq new_user_registration_path
  end

  it 'ログインリンクをクリックするとログインページ遷移' do
    click_link 'ログイン'
    expect(current_path).to eq new_user_session_path
  end
end
