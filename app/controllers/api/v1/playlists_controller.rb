module Api
  module V1
    class PlaylistsController < PrivateController
      load_and_authorize_resource :event
      load_and_authorize_resource :screen, through: :event
      load_and_authorize_resource through: :screen, singleton: true

      def show
        render json: @playlist, each_serializer: PlaylistSerializer, status: :ok, root: :data
      end

      def update
        if @playlist.update(playlist_params)
          render json: @playlist, each_serializer: PlaylistSerializer, status: :ok, root: :data
        else
          render json: { error: @playlist.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        if @playlist.destroy
          @screen.create_playlist
          render json: @playlist, each_serializer: PlaylistSerializer, status: :ok, root: :data
        else
          render json: { error: @playlist.errors }, status: :unprocessable_entity
        end
      end

      private

      def playlist_params
        params.require(:playlist).permit(:name, :duration)
      end
    end
  end
end
