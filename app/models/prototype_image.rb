class PrototypeImage < ActiveRecord::Base
  belongs_to :prototype
  mount_uploader :content, PrototypeImageUploader
  enum role: %i{ main sub }
  validates :content,
            :role, presence: true
end
