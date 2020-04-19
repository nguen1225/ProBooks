# User.create!(
# 	name: "owner",
# 	email: "hogehoge@example.com",
# 	password: "foobar",
# 	uid: "123456",
# )

# 10.times do |n|
# 	name  = Faker::Name.name
# 	email = "hogehoge-#{n+1}@example.org"
# 	password = "password"
# 	uid = "#{n+1}"
# 	User.create!(name:  name,
# 				 email: email,
# 				 password:              password,
# 				 password_confirmation: password,
# 				 uid: uid)
# end


# #categoryデータ
# Category.create!(
# 	name: "HTML&CSS"
# )
# Category.create!(
# 	name: "Javascript"
# )
# Category.create!(
# 	name: "PHP"
# )
# Category.create!(
# 	name: "Ruby"
# )
# Category.create!(
# 	name: "AWS"
# )
# Category.create!(
# 	name: "Phython"
# )

#Bookデータ

# Book.create!(
# 	title: 'よくわかるruby',
# 	content: 'ホゲホゲホゲホゲ',
# 	level: 'hard',
# 	volume: 'few',
# 	category_id: 1,
# 	user_id: 1
# )


# #レビューデータ
# 10.times do |n|
# 	title = "わかりやすい"
# 	body = Faker::Lorem.sentence
# 	rate = 5
# 	book_id = 1
# 	user_id = 2
# 	Review.create!(
# 		title: title,
# 		body: body,
# 		rate: rate,
# 		book_id: book_id,
# 		user_id: user_id
# 	)
# end

LevelStandard.create!(
	level: 1,
	threshould: 0
)
LevelStandard.create!(
	level: 2,
	threshould: 3
)
LevelStandard.create!(
	level: 3,
	threshould: 6
)
LevelStandard.create!(
	level: 4,
	threshould: 9
)
LevelStandard.create!(
	level: 5,
	threshould: 12
)

