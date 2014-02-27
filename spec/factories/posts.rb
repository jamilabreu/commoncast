# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :post do
	  factory :link, class: Link do
	  	after(:build) { |post| post.title = post.url }
	  	url Faker::Internet.http_url
	  end
	  factory :status, class: Status do
	  	after(:build) { |post| post.title = post.body }
	  	body Faker::Lorem.paragraph
	  end
	end
end