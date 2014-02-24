class Post < ActiveRecord::Base
	include Filterable
  belongs_to :user
  has_many :community_posts, dependent: :destroy
  has_many :communities, -> { order :name }, through: :community_posts

  validates :body, presence: true
end
