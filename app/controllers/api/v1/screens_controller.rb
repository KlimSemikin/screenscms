module Api
  module V1
    class ScreensController < PrivateController
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

      def screen_params
        params.permit(:name, :event_id)
      end
    end
  end
end
