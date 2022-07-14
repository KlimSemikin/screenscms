module Api
  module V1
    class EventsController < PrivateController
      load_and_authorize_resource

      def index
        render json: @events, each_serializer: EventSerializer, status: :ok, root: :data
      end

      def show
        render json: @event, each_serializer: EventSerializer, status: :ok, root: :data
      end

      def create
        if @event.save
          render json: @event, each_serializer: EventSerializer, status: :ok, root: :data
        else
          render json: { error: @event.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @event.update(event_params)
          render json: @event, each_serializer: EventSerializer, status: :ok, root: :data
        else
          render json: { error: @event.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        if @event.destroy
          render json: @event, each_serializer: EventSerializer, status: :ok, root: :data
        else
          render json: { error: @event.errors }, status: :unprocessable_entity
        end
      end

      private

      def event_params
        params.require(:event).permit(:name)
      end
    end
  end
end
