module Api
  module V1
    class ContentsController < PrivateController
      load_and_authorize_resource :event
      load_and_authorize_resource :screen, through: :event
      load_and_authorize_resource :playlist, through: :screen, singleton: true
      load_resource :content, through: :playlist

      def index
        @contents = @playlist.playlist_contents
        render json: @contents, each_serializer: PlaylistContentSerializer, status: :ok, root: :data
      end

      def show
        render json: @content, status: :ok
      end

      def create
        result = Contents::CreateContentService.call(@event, @playlist, content_params)
        if result.success
          render json: result.content, serializer: PlaylistContentSerializer, status: :ok, root: :data
        else
          render json: { error: result.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @content.update(content_params)
          render json: @content, each_serializer: PlaylistContentSerializer, status: :ok, root: :data
        else
          render json: { error: @content.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        result = Contents::DestroyContentService.call(@event, @playlist, @content, params.permit(:id))
        if result.success
          render json: result.content, serializer: ContentSerializer, status: :ok, root: :data
        else
          render json: { error: result.errors }, status: :unprocessable_entity
        end
      end

      def move_higher
        result = Contents::MoveHigherContentService.call(@playlist, params.permit(:id))
        if result.success
          render json: result.content, serializer: PlaylistContentSerializer, status: :ok, root: :data
        else
          render json: { error: result.errors }, status: :unprocessable_entity
        end
      end

      def move_lower
        result = Contents::MoveLowerContentService.call(@playlist, params.permit(:id))
        if result.success
          render json: result.content, serializer: PlaylistContentSerializer, status: :ok, root: :data
        else
          render json: { error: result.errors }, status: :unprocessable_entity
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
