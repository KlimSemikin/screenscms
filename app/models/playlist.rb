class Playlist < ApplicationRecord
  belongs_to :screen

  has_and_belongs_to_many :contents
  before_destroy { contents.clear }

  validates :name, presence: true, length: { maximum: 255 }, allow_blank: false
  validates :duration, presence: true, numericality: { less_than_or_equal_to: 10000, only_integer: true }
end
