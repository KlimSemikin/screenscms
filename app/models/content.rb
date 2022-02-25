class Content < ApplicationRecord
  has_and_belongs_to_many :playlists

  validates :content, presence: true

  mount_uploader :content, ContentUploader

  default_scope { order(created_at: :desc) }
end
