module Api
  module V1
    class EventsController < PrivateController
      load_and_authorize_resource :except => [:create]

      def index
        render json: @events, each_serializer: EventSerializer, status: :ok
      end

      def show
        render json: @event, each_serializer: EventSerializer, status: :ok
      end

      def create
        @event = current_user.events.new(
          name: event_params[:event][:name]
        )
        if @event.save
          render json: @event, each_serializer: EventSerializer, status: :ok
        else
          render json: { error: @event.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @event.update(
          name: event_params[:event][:name]
        )
          render json: @event, each_serializer: EventSerializer, status: :ok
        else
          render json: { error: @event.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        if @event.destroy
          render json: @event, each_serializer: EventSerializer, status: :ok
        else
          render json: { error: @event.errors }, status: :unprocessable_entity
        end
      end

      private

      def event_params
        params.permit(:id, event: [:name])
      end
    end
  end
end
