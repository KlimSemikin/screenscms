class PlaylistContentSerializer < ActiveModel::Serializer
  attributes :id, :url

  def url
    object.content.content.url
  end
end
