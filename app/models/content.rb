class Content < ApplicationRecord
  has_many :playlist_contents, dependent: :destroy
  has_many :playlists, -> { order('playlist_contents.position ASC') }, through: :playlist_contents

  validates :content, presence: true

  mount_uploader :content, ContentUploader
end
