puts "CREATE ADMIN"
AdminUser.create email: "admin@example.com", password: "password"

puts "CREATE COMMUNITIES"
schools = %W( Yale Harvard Princeton Dartmouth Columbia Brown Cornell MIT Stanford )
schools.each do |name|
	School.create name: name, slug: name.parameterize
end

cultures = %W( Dominican American English Dutch French German Jamaican Indian Chinese Japanese )
cultures.each do |name|
	Culture.create name: name, slug: name.parameterize
end

puts "CREATE USERS"
10.times do
	User.create(
		email: Faker::Internet.email,
		password: "password",
		communities: Community.all.sample(rand(2..6))
	)
end

puts "CREATE POSTS"
50.times do
	user = User.all.sample
	user.links.create(
		title: Faker::Lorem.sentence,
		body: Faker::Internet.http_url,
		communities: Community.all.sample(rand(2..6)),
		approved: rand(1..3).even? ? true : false
	)

	user.statuses.create(
		body: Faker::Lorem.paragraph[0, rand(70..140)],
		communities: Community.all.sample(rand(2..6)),
		approved: rand(1..3).even? ? true : false
	)
end