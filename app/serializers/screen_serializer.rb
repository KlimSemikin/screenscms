class ScreenSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_one :playlist
end
