class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :notifications, dependent: :destroy
	has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
    has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
    has_many :following, through: :active_relationships, source: :followed              
	has_many :followers, through: :passive_relationships, source: :follower
	#Follow an user
	def follow(other_user)
    	active_relationships.create(followed_id: other_user.id)
  	end

  	# Unfollows a user.
  	def unfollow(other_user)
    	active_relationships.find_by(followed_id: other_user.id).destroy
  	end

  	# Returns true if the current user is following the other user.
  	def following?(other_user)
    	following.include?(other_user)
  	end

    def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

	
	has_attached_file :avatar, styles: { medium: '152x152#' }  
	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable
	validates :user_name, presence: true, length: { minimum: 4, maximum: 16 }
end
