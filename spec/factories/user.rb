# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	email Faker::Internet.email
  	password Devise.friendly_token[0..8]
  end
end