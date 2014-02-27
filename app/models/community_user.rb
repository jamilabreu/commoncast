class CommunityUser < ActiveRecord::Base
  belongs_to :community
  belongs_to :user

  validates :community_id, uniqueness: { scope: :user_id }
  validates :user_id, uniqueness: { scope: :community_id }
end
