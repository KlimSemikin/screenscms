class PlaylistContentSerializer < ActiveModel::Serializer
  attributes :id, :position, :url

  def url
    object.content.content.url
  end

  def id
    object.content.id
  end
end
