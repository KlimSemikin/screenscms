module Contents
  class MoveHigherContentService
    include Callable

    def initialize(playlist, content_params)
      @playlist = playlist
      @content_params = content_params
    end

    def call
      move_higher_content
    end

    private

    def move_higher_content
      playlist_content = @playlist.playlist_contents.where(["content_id = ?", @content_params[:id]]).last

      OpenStruct.new(success: playlist_content.move_higher, errors: playlist_content.errors, content: playlist_content)
    end
  end
end
