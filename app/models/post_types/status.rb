class Status < Post
	before_validation :set_title

	def set_title
		self.title = self.body
	end

  def to_partial_path
    'posts/post' # TODO: Update when ready
  end
end