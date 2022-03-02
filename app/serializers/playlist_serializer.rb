class PlaylistSerializer < ActiveModel::Serializer
  attributes :id, :name, :duration

  has_many :playlist_contents, key: :content
end
