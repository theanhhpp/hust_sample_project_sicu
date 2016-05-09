class Post < ActiveRecord::Base
	
	
	belongs_to :user

	has_many :comments, dependent: :destroy
	has_many :notifications, dependent: :destroy
	
	validates :user_id, presence: true
	validates :image, presence: true
	has_attached_file :image, styles: { :medium => "640x" }
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	self.per_page = 10


	acts_as_taggable
	has_reputation :votes, source: :user, aggregated_by: :sum
	def self.popular
	  reorder('votes desc').find_with_reputation(:votes, :all)
	end
	def votes
	  read_attribute(:votes) || post_votes.sum(:value)
	end
	def user_name
		self.user.user_name
	end

	def self.search(search)
	  where("caption LIKE ?", "%#{search}%")
	end
end
