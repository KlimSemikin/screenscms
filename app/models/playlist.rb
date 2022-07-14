class Playlist < ApplicationRecord
  belongs_to :screen
  has_many :playlist_contents
  has_many :contents, -> { order('playlist_contents.position ASC') }, through: :playlist_contents, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }, allow_blank: false
  validates :duration, presence: true, numericality: { less_than_or_equal_to: 10000, only_integer: true }
end
