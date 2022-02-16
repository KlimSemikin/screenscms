class User < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :screens, through: :events, dependent: :destroy
  has_many :playlists, through: :screens, dependent: :destroy
  has_many :contents, through: :playlists, dependent: :destroy
end
