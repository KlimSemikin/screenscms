module Api
  module V1
    class ContentsController < PrivateController
      load_and_authorize_resource :event
      load_resource :screen, through: :event, :except => [:create]
      load_resource :playlist, through: :screen, singleton: true, :except => [:create]
      load_resource :content, through: :playlist, :except => [:create]

      def index
        @contents = @playlist.contents
        render json: @contents, each_serializer: ContentSerializer, status: :ok
      end

      def show
        render json: @content, each_serializer: ContentSerializer, status: :ok
      end

      def create
        @content = Content.find_or_create_by(content: content_params[:content][:content])
        if @content
          unless @event.screens.find(content_params[:screen_id]).playlist.contents.exists?(@content.id)
            @event.screens.find(content_params[:screen_id]).playlist.contents << @content
          end
          render json: @content, each_serializer: ContentSerializer, status: :ok
        else
          render json: { error: @content.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @content.update(content_params[:content])
          render json: @content, each_serializer: ContentSerializer, status: :ok
        else
          render json: { error: @content.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        if @content.destroy
          render json: @content, each_serializer: ContentSerializer, status: :ok
        else
          render json: { error: @content.errors }, status: :unprocessable_entity
        end
      end

      private

      def content_params
        params.require(:content)
        params.permit(:id, :event_id, :screen_id, content: [:content])
      end
    end
  end
end
