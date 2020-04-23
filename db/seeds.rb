# User.create!(
# 	name: "owner",
# 	email: "hogehoge@example.com",
# 	password: "foobar",
# 	uid: "123456",
# )



# # #categoryデータ
# Category.create!(
# 	name: "HTML&CSS"
# )
# Category.create!(
# 	name: "Javascript"
# )
# Category.create!(
# 	name: "Ruby"
# )
# Category.create!(
# 	name: "RubyOnRails"
# )
# Category.create!(
# 	name: "AWS"
# )
# Category.create!(
# 	name: "Git/Github"
# )

# #Bookデータ
# Book.create!(
# 	title: 'よくわかるHTML',
# 	content: 'ホゲホゲホゲホゲ',
# 	level: 'hard',
# 	volume: 'few',
# 	category_id: 1,
# 	user_id: 2
# )
# Book.create!(
# 	title: 'よくわかるruby',
# 	content: 'ホゲホゲホゲホゲ',
# 	level: 'hard',
# 	volume: 'few',
# 	category_id: 2,
# 	user_id: 1
# )
# Book.create!(
# 	title: 'よくわかるrubyonrails',
# 	content: 'ホゲホゲホゲホゲ',
# 	level: 'hard',
# 	volume: 'few',
# 	category_id: 3,
# 	user_id: 3
# )
# Book.create!(
# 	title: 'よくわかるruby',
# 	content: 'ホゲホゲホゲホゲ',
# 	level: 'hard',
# 	volume: 'few',
# 	category_id: 4,
# 	user_id: 1
# )
# Book.create!(
# 	title: 'よくわかるGIT',
# 	content: 'ホゲホゲホゲホゲ',
# 	level: 'hard',
# 	volume: 'few',
# 	category_id: 5,
# 	user_id: 3
# )
# Book.create!(
# 	title: 'よくわかるAWS',
# 	content: 'ホゲホゲホゲホゲ',
# 	level: 'hard',
# 	volume: 'few',
# 	category_id: 6,
# 	user_id: 4
# )



#レビューデータ
10.times do |n|
	title = "わかりやすい"
	body = Faker::Lorem.sentence
	rate = 4
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



