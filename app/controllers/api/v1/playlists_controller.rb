module Api
  module V1
    class PlaylistsController < PrivateController
      load_and_authorize_resource :event
      load_resource :screen, through: :event, :except => [:create]
      load_resource :playlist, through: :screen, singleton: true, :except => [:create]

      def show
        if @playlist
          render json: @playlist, each_serializer: PlaylistSerializer, status: :ok
        else
          render json: { error: 'No playlist yet' }, status: :not_found
        end
      end

      def create
        @playlist = @event.screens.find(playlist_params[:screen_id]).create_playlist(playlist_params[:playlist])
        if @playlist.valid?
          render json: @playlist, each_serializer: PlaylistSerializer, status: :ok
        else
          render json: { error: @playlist.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @playlist.update(playlist_params[:playlist])
          render json: @playlist, each_serializer: PlaylistSerializer, status: :ok
        else
          render json: { error: @playlist.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        if @playlist.destroy
          @playlist.create_playlist(name: "playlist")
          render json: @playlist, each_serializer: PlaylistSerializer, status: :ok
        else
          render json: { error: @playlist.errors }, status: :unprocessable_entity
        end
      end

      private

      def playlist_params
        params.require(:playlist)
        params.permit(:event_id, :screen_id, playlist: [:name, :duration])
      end
    end
  end
end
