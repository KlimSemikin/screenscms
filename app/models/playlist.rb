class Playlist < ApplicationRecord
  belongs_to :screen

  has_and_belongs_to_many :contents
  before_destroy { contents.clear }

  validates :name, presence: true, length: { maximum: 255 }, allow_blank: false
end
