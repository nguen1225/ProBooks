module LoginSupport
  def sign_in_as(user)
    visit root_path
    click_link 'Log In'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_on 'Log In'
  end

  def sign_in_as_admin(admin)
    visit new_admin_session_path
    fill_in 'メールアドレス', with: admin.email
    fill_in 'パスワード', with: admin.password
    click_on 'Log In'
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
