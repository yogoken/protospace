class Prototype < ActiveRecord::Base
  belongs_to :user
  has_many   :prototype_images, dependent: :destroy

  accepts_nested_attributes_for :prototype_images, allow_destroy: true,
                                                   reject_if: :all_blank
  validates :title,
            :catch_copy,
            :concept, presence: true
end
