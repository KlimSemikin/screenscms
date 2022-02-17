module Api
  module V1
    class PlaylistsController < PrivateController
      def index
      end

      def show
      end

      def create
      end

      def update
      end

      def destroy
      end

      private

      def playlist_params
        params.permit(:name, :duration)
      end
    end
  end
end
