module Contents
  class CreateContentService
    include Callable

    def initialize(event, playlist, content_params)
      @event = event
      @playlist = playlist
      @content_params = content_params
    end

    def call
      create_content
    end

    private

    def create_content
      content = @event.contents.find_by(content: @content_params[:content].original_filename) || Content.create(@content_params)
      content_valid = content.valid?
      @playlist.contents << content if content_valid

      playlist_content = @playlist.playlist_contents.last

      OpenStruct.new(success: content_valid, errors: content.errors, content: playlist_content)
    end
  end
end
