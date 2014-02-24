class PostsController < ApplicationController
  require 'open-uri'
  require 'nokogiri'

  before_action :set_post, only: [:show]

  def index
    @post = Post.new
    @posts = Post.filter(current_user, params)
    # redirect_to posts_path(approved: false) if @posts.blank?
  end

  def show
  end

  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def fetch
    url = params[:q]
    begin
      page = Nokogiri::HTML(open(url))
      begin
        title = page.at('meta[property="og:title"]')['content']
      rescue
        title = page.title
      end
    rescue
      title = url
    end
    @title = title.strip
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end
    def post_params
      params.require(:post).permit(:title, :body, :url, :type, community_ids: [])
    end
end