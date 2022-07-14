module Api
  module V1
    class ScreensController < PrivateController
      load_and_authorize_resource :event
      load_and_authorize_resource through: :event

      def index
        @screens = @event.screens
        render json: @screens, each_serializer: ScreenSerializer, status: :ok, root: :data
      end

      def show
        render json: @screen, each_serializer: ScreenSerializer, status: :ok, root: :data
      end

      def create
        if @screen.save
          @screen.create_playlist
          render json: @screen, each_serializer: ScreenSerializer, status: :ok, root: :data
        else
          render json: { error: @screen.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @screen.update(screen_params)
          render json: @screen, each_serializer: ScreenSerializer, status: :ok, root: :data
        else
          render json: { error: @screen.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        if @screen.destroy
          render json: @screen, each_serializer: ScreenSerializer, status: :ok, root: :data
        else
          render json: { error: @screen.errors }, status: :unprocessable_entity
        end
      end

      private

      def screen_params
        params.require(:screen).permit([:name])
      end
    end
  end
end
