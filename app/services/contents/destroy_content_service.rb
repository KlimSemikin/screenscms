module Contents
  class DestroyContentService
    include Callable

    def initialize(event, playlist, content, content_params)
      @event = event
      @playlist = playlist
      @content = content
      @content_params = content_params
    end

    def call
      destroy_content
    end

    private

    def destroy_content
      playlist_content = @playlist.playlist_contents.find_by(content_id: @content_params[:id])
      content_destroy_result = playlist_content.destroy

      if content_destroy_result && !@event.contents.exists?(@content.id)
        @content.destroy
      end

      OpenStruct.new(success: content_destroy_result, errors: playlist_content.errors, content: @content)
    end
  end
end
