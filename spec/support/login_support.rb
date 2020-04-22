module LoginSupport
  def sign_in_as(user)
    visit root_path
    click_link 'Log In'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_on 'Log In'
  end

  def request_login(user)
    @user = user
  end

  def logout
    @user = nil
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
