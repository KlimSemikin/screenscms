module Api
  module V1
    class ScreensController < PrivateController
      load_and_authorize_resource :event
      load_resource through: :event, :except => [:create]

      def index
        @screens = @event.screens
        render json: @screens, each_serializer: ScreenSerializer, status: :ok
      end

      def show
        render json: @screen, each_serializer: ScreenSerializer, status: :ok
      end

      def create
        @screen = @event.screens.new(screen_params[:screen])
        if @screen.save
          @screen.create_playlist(name: "playlist")
          render json: @screen, each_serializer: ScreenSerializer, status: :ok
        else
          render json: { error: @screen.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @screen.update(screen_params[:screen])
          render json: @screen, each_serializer: ScreenSerializer, status: :ok
        else
          render json: { error: @screen.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        if @screen.destroy
          render json: @screen, each_serializer: ScreenSerializer, status: :ok
        else
          render json: { error: @screen.errors }, status: :unprocessable_entity
        end
      end

      private

      def screen_params
        params.require(:screen)
        params.permit(:id, :event_id, screen: [:name])
      end
    end
  end
end
