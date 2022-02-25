class Content < ApplicationRecord
  has_and_belongs_to_many :playlists

  validates :content, presence: true

  mount_uploader :content, ContentUploader
end
