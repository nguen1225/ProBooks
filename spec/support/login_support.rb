module LoginSupport
  def sign_in_as(user)
    visit root_path
    click_link 'ログイン'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_on 'Log In'
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end