class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_many :prototypes
  has_many :likes
  has_many :comments

  validates :username, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                                    format: { with: VALID_EMAIL_REGEX },
                                uniqueness: { case_sensitive: true }
  validates :password, presence: true, length: { minimum: 6 }
end
