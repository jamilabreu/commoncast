module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(user, params)
      posts = Post.preload(:communities, :users, :user).joins(:communities).where(communities: { id: user.community_ids }).group('posts.id')
      posts = posts.where(approved: true) unless params[:all]
      if params[:relevant]
        posts = posts.select('posts.*, COUNT(DISTINCT communities.id) AS community_count').order('community_count DESC')
      elsif params[:recent]
        posts = posts.order(created_at: :desc)
      else
        posts = posts #TODO: Reputation System
      end
      return posts
    end
  end
end