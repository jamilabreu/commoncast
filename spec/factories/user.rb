FactoryGirl.define do
  factory :user do
  	email "abreu.jamil@gmail.com"
  	password Devise.friendly_token[0..8]
  end
end