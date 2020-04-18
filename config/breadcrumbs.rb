crumb :root do
  link "トップページ", root_path
end

#root~
crumb :search do
  link "書籍検索", books_path
  parent :root
end

crumb :new_book do
  link '書籍の登録', new_book_path
  parent :root
end

crumb :book_page do |book|
  link book.title, book_path(book)
  parent :search
end

crumb :book_edit do |book|
  link "#{book.title}の編集", edit_book_path(book)
  parent :book_page, book
end

#root~
crumb :my_page do |user|
  link "#{user.name}", user_path(user)
  parent :root
end

crumb :notifications do
    link "通知", notifications_path
    parent :root
end

crumb :user_edit do |user|
  link "ユーザー情報編集", edit_user_path(user)
  parent :my_page, user
end

#root~
crumb :login do
  link "ログイン", new_user_session_path
  parent :root
end

crumb :registration do
  link "新規登録", new_user_registration_path
  parent :root
end

#root~
crumb :reviews do
  link "最新レビュー", reviews_path
  parent :root
end

#root~
crumb :admins do
  link "管理者ページ", admins_root_path
  parent :root
end

crumb :admin_session do
  link "管理者ログイン", admin_session_path
  parent :root
end

crumb :admin_users do
  link "ユーザー管理"
  parent :root
end

crumb :admin_books do
  link "書籍管理"
  parent :root
end