crumb :root do
  link "トップページ", root_path
end

#root~
crumb :search do
  link "書籍検索", books_path
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