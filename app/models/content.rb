class Content < ApplicationRecord
  has_and_belongs_to_many :playlists

  # mount_uploader :content, ContentUploader

  validates :content, presence: true
end
