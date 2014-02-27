class User < ActiveRecord::Base
	# COMMUNITY_TYPES = %w( City Company Country Culture Degree Field Gender Interest Language Orientation Profession Relationship Religion School Standing )
	COMMUNITY_TYPES = %w( School Culture )

	has_many :community_users, dependent: :destroy
	has_many :communities, -> { order :name }, through: :community_users
  has_many :user_posts, dependent: :destroy
  has_many :posts, through: :user_posts
  has_many :links, through: :user_posts, source: :post, class: Link
  has_many :statuses, through: :user_posts, source: :post, class: Status
  has_many :posts
  has_many :links
  has_many :statuses

	COMMUNITY_TYPES.each do |community_type|
    has_many community_type.downcase.pluralize.to_sym, through: :community_users, class_name: community_type, source: :community
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  mount_uploader :image, ImageUploader

  validates :email, presence: true, uniqueness: true, format: { with: Devise.email_regexp }
  validates :password, presence: true, on: :create

  def dummy_image
    "http://graph.facebook.com/3027#{id}/picture?type=large"
  end
end
