class Prototype < ActiveRecord::Base
  belongs_to :user
  has_many   :prototype_images, dependent: :destroy
  has_many   :likes,            dependent: :destroy
  has_many   :comments,         dependent: :destroy

  accepts_nested_attributes_for :prototype_images, allow_destroy: true,
                                                   reject_if: :all_blank
  validates :title,
            :catch_copy,
            :concept, presence: true

  def liked_by?(user)
    likes.find_by(user_id: user)
  end
end
