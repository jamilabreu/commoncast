class Post < ActiveRecord::Base
	include Filterable

  has_many :community_posts, dependent: :destroy
  has_many :communities, -> { order :name }, through: :community_posts
  has_many :user_posts, dependent: :destroy
  has_many :users, through: :user_posts
  belongs_to :user

  validates :body, presence: true
  validates :title, presence: true

  after_create :add_creator_to_users

  def add_creator_to_users
  	users << user
  end

  def is_retweet?(user)
    users.include?(user) && self.user != user
  end
end
