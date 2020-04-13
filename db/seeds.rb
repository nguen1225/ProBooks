# User.create!(
# 	name: "owner",
# 	email: "hogehoge@example.com",
# 	password: "foobar",
# 	uid: "123456",
# )

10.times do |n|
	name  = Faker::Name.name
	email = "hogehoge-#{n+1}@example.org"
	password = "password"
	uid = "#{n+1}"
	User.create!(name:  name,
				 email: email,
				 password:              password,
				 password_confirmation: password,
				 uid: uid)
end

Book.create!(
	title: 'すごくわかるRuby',
	content: 'ホゲホゲホゲホゲホゲほげ',
	category: 'ruby',
	user_id: 1,
)
Book.create!(
	title: 'すごくわかるJavascript',
	content: 'ホゲホゲホゲホゲホゲほげ',
	category: 'javascript',
	user_id: 1,
)
Book.create!(
	title: 'すごくわかるPHP',
	content: 'ホゲホゲホゲホゲホゲほげ',
	category: 'php',
	user_id: 1,
)
Book.create!(
	title: 'すごくわかるHTML',
	content: 'ホゲホゲホゲホゲホゲほげ',
	category: 'html',
	user_id: 1,
)

10.times do |n|
	title = "わかりやすい"
	body = Faker::Lorem.sentence
	rate = 5
	book_id = 1
	user_id = 2
	Review.create!(
		title: title,
		body: body,
		rate: rate,
		book_id: book_id,
		user_id: user_id
	)
end
