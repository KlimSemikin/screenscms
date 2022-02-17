module Api
  module V1
    class EventsController < PrivateController
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

      def event_params
        params.permit(:name)
      end
    end
  end
end
