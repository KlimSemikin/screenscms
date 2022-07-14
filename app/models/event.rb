class Event < ApplicationRecord
  belongs_to :user

  has_many :screens, dependent: :destroy
  has_many :playlists, through: :screens, dependent: :destroy
  has_many :contents, through: :playlists, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }, allow_blank: false
end
