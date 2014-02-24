class Community < ActiveRecord::Base
  has_many :community_posts, dependent: :destroy
  has_many :posts, through: :community_posts
	has_many :community_users, dependent: :destroy
	has_many :users, through: :community_users
end