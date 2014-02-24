module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(user, params)
      posts = Post.joins(:communities).where(communities: { id: user.community_ids }).group("posts.id")
      posts = posts.where(approved: true) unless params[:all]
      if params[:relevant]
        posts = posts.select('posts.*, COUNT(distinct communities.id) AS community_count').order('community_count DESC')
      else
        posts = posts.order(created_at: :desc)
      end
      return posts
    end
  end
end