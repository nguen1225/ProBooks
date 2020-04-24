User.create!(
	name: "owner",
	email: "hogehoge@example.com",
	password: "foobar",
	uid: "123456",
)

15.times do |n|
	name  = Faker::Name.name
	email = "hogehoge-#{n+1}@example.org"
	password = "password"
	uid = "#{n+1}"
	User.create!(name:  name,
				email: email,
				password:              password,
				password_confirmation: password,
				uid: uid )

end

# #categoryデータ
Category.create!(
	id:1,
	name: "HTML&CSS"
)
Category.create!(
	id:2,
	name: "Javascript"
)
Category.create!(
	id: 3,
	name: "Ruby"
)
Category.create!(
	id:4,
	name: "RubyOnRails"
)
Category.create!(
	id:5,
	name: "AWS"
)
Category.create!(
	id: 6,
	name: "Git/Github"
)

#Bookデータ
Book.create!(
	title: 'よくわかるHTML',
	content: 'ホゲホゲホゲホゲ',
	level: 'hard',
	volume: 'few',
	category_id: 1,
	user_id: 2
)
Book.create!(
	title: 'よくわかるruby',
	content: 'ホゲホゲホゲホゲ',
	level: 'hard',
	volume: 'few',
	category_id: 2,
	user_id: 1
)
Book.create!(
	title: 'よくわかるrubyonrails',
	content: 'ホゲホゲホゲホゲ',
	level: 'hard',
	volume: 'few',
	category_id: 3,
	user_id: 3
)
Book.create!(
	title: 'よくわかるruby',
	content: 'ホゲホゲホゲホゲ',
	level: 'hard',
	volume: 'few',
	category_id: 1,
	user_id: 1
)
Book.create!(
	title: 'よくわかるGIT',
	content: 'ホゲホゲホゲホゲ',
	level: 'hard',
	volume: 'few',
	category_id: 1,
	user_id: 3
)
Book.create!(
	title: 'よくわかるAWS',
	content: 'ホゲホゲホゲホゲ',
	level: 'hard',
	volume: 'few',
	category_id: 1,
	user_id: 4
)

#レビューデータ
10.times do |n|
	title = "わかりやすい"
	body = Faker::Lorem.sentence
	rate = 1..5
	book_id = 1
	user_id = 1
	Review.create!(
		title: title,
		body: body,
		rate: rate,
		book_id: book_id,
		user_id: user_id
	)
end

#レベルデータ
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
LevelStandard.create!(
	level: 6,
	threshould: 15
)
LevelStandard.create!(
	level: 7,
	threshould: 18
)
LevelStandard.create!(
	level: 9,
	threshould: 21
)
LevelStandard.create!(
	level: 10,
	threshould: 24
)
LevelStandard.create!(
	level: 11,
	threshould: 27
)
LevelStandard.create!(
	level: 12,
	threshould: 30
)
LevelStandard.create!(
	level: 13,
	threshould: 33
)
LevelStandard.create!(
	level: 14,
	threshould: 36
)



