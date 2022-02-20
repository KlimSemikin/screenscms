module Api
  module V1
    class EventsController < PrivateController
      load_and_authorize_resource

      def index
        @events = Event.accessible_by(current_ability, :read)
        render json: @events, each_serializer: EventSerializer, status: :ok
      end

      def show
        @event = Event.accessible_by(current_ability, :read).find(params[:id])
        render json: @event, each_serializer: EventSerializer, status: :ok
      end

      def create
        @event = current_user.events.new(event_params)
        if @event.save
          render json: @event, each_serializer: EventSerializer, status: :ok
        else
          render json: { error: @event.errors }, status: :unprocessable_entity
        end
      end

      def update
        @event = Event.accessible_by(current_ability, :update).find(params[:id])
        if @event.update(event_params)
          render json: @event, each_serializer: EventSerializer, status: :ok
        else
          render json: { error: @event.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @event = Event.accessible_by(current_ability, :destroy).find(params[:id])
        if @event.destroy
          render json: @event, each_serializer: EventSerializer, status: :ok
        else
          render json: { error: @event.errors }, status: :unprocessable_entity
        end
      end

      private

      def event_params
        params.permit(:name)
      end
    end
  end
end
