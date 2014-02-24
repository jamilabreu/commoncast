class User < ActiveRecord::Base
	# COMMUNITY_TYPES = %w( City Company Country Culture Degree Field Gender Interest Language Orientation Profession Relationship Religion School Standing )
	COMMUNITY_TYPES = %w( School Culture )

	has_many :posts
  has_many :links
  has_many :statuses
	has_many :community_users, dependent: :destroy
	has_many :communities, -> { order :name }, through: :community_users
	COMMUNITY_TYPES.each do |community_type|
    has_many community_type.downcase.pluralize.to_sym, through: :community_users, class_name: community_type, source: :community
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
end
