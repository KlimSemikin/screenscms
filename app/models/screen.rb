class Screen < ApplicationRecord
  belongs_to :event

  has_one :playlist, dependent: :destroy
  has_many :contents, through: :playlist, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }, allow_blank: false
end
