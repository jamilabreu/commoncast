class UserPost < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id }
  validates :post_id, uniqueness: { scope: :user_id }
end
