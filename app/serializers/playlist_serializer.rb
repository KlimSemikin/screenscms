class PlaylistSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration

  has_many :contents
end
