class CommunitiesController < ApplicationController
	before_action :set_community, only: [:show]

	def	show
		@post = Post.new
		@posts = @community.posts.filter(current_user, params)
	end

	private
    def set_community
    	@community = Community.find(params[:id])
    end
end