module Api
  module V1
    class ContentsController < PrivateController
      load_and_authorize_resource :event
      load_and_authorize_resource :screen, through: :event
      load_and_authorize_resource :playlist, through: :screen, singleton: true
      load_resource :content, through: :playlist

      def index
        @contents = @playlist.playlist_contents
        render json: @contents, each_serializer: PlaylistContentSerializer, status: :ok
      end

      def show
        render json: @content, status: :ok
      end

      def create
        @content = @event.contents.find_by(content: content_params[:content].original_filename) || Content.create(content_params)
        if @content.valid?
          @playlist.contents << @content
          render json: @content, each_serializer: PlaylistContentSerializer, status: :ok
        else
          render json: { error: @content.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @content.update(content_params)
          render json: @content, each_serializer: PlaylistContentSerializer, status: :ok
        else
          render json: { error: @content.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @playlist_content = @playlist.playlist_contents.find_by(content_id: params.permit(:id)[:id])
        if @playlist_content.destroy
          @content.destroy unless @event.contents.exists?(@content.id)
          render json: @content, each_serializer: PlaylistContentSerializer, status: :ok
        else
          render json: { error: @playlist.errors }, status: :unprocessable_entity
        end
      end

      def move_higher
        @playlist_content = @playlist.playlist_contents.where(["content_id = ?", params.permit(:id)[:id]]).last
        if @playlist_content.move_higher
          render json: @playlist_content, each_serializer: PlaylistContentSerializer, status: :ok
        else
          render json: { error: @playlist_content.errors }, status: :unprocessable_entity
        end

      end

      def move_lower
        @playlist_content = @playlist.playlist_contents.where(["content_id = ?", params.permit(:id)[:id]]).first
        if @playlist_content.move_lower
          render json: @playlist_content, each_serializer: PlaylistContentSerializer, status: :ok
        else
          render json: { error: @playlist_content.errors }, status: :unprocessable_entity
        end
      end

      private

      def content_params
        params.require(:content)
        params.permit(:content)
      end
    end
  end
end
