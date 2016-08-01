class PrototypeImage < ActiveRecord::Base
  belongs_to :prototype
  mount_uploader :content, PrototypeImageUploader
  enum role: %i{ main sub }
end
