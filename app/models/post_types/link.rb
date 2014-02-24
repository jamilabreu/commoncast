class Link < Post
	before_validation :set_url

	validates :title, presence: true
	validates :url, presence: true

	def set_url
		self.url = self.body
	end

  def to_partial_path
    'posts/post' # TODO: Update when ready
  end
end