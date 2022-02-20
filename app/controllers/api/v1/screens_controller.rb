module Api
  module V1
    class ScreensController < PrivateController
      load_and_authorize_resource :event
      load_and_authorize_resource :screen, :through => :event

      def index
        @screens = Event.find(screen_params[:event_id]).screens
        render json: @screens, each_serializer: ScreenSerializer, status: :ok
      end

      def show
        @event = Event.find(screen_params[:event_id])
        @screen = @event.screens.find(screen_params[:id])
        render json: @screen, each_serializer: ScreenSerializer, status: :ok
      end

      def create
      end

      def update
      end

      def destroy
      end

      private

      def screen_params
        params.permit(:id, :event_id, screen: [:name])
      end
    end
  end
end
