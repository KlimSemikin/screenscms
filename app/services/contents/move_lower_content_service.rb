module Contents
  class MoveLowerContentService
    include Callable

    def initialize(playlist, content_params)
      @playlist = playlist
      @content_params = content_params
    end

    def call
      move_lower_content
    end

    private

    def move_lower_content
      playlist_content = @playlist.playlist_contents.where(["content_id = ?", @content_params[:id]]).first

      OpenStruct.new(success: playlist_content.move_lower, errors: playlist_content.errors, content: playlist_content)
    end
  end
end
