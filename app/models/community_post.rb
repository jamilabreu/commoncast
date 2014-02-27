class CommunityPost < ActiveRecord::Base
  belongs_to :community
  belongs_to :post

  validates :community_id, uniqueness: { scope: :post_id }
  validates :post_id, uniqueness: { scope: :community_id }
end
