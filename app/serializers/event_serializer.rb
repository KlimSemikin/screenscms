class EventSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :screens
end
