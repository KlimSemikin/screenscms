module Api
  module V1
    class ContentsController < PrivateController
      load_and_authorize_resource :event
      load_and_authorize_resource :screen, through: :event
      load_and_authorize_resource :playlist, through: :screen, singleton: true
      load_resource through: :playlist

      def index
        @contents = @playlist.contents
        render json: @contents, each_serializer: ContentSerializer, status: :ok
      end

      def show
        render json: @content, each_serializer: ContentSerializer, status: :ok
      end

      def create
        @content = @event.contents.find_by(content_params) || Content.create(content_params)
        if @content.valid?
          @playlist.contents << @content
          render json: @content, each_serializer: ContentSerializer, status: :ok
        else
          render json: { error: @content.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @content.update(content_params)
          render json: @content, each_serializer: ContentSerializer, status: :ok
        else
          render json: { error: @content.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        if @playlist.contents.delete(@content)
          render json: @content, each_serializer: ContentSerializer, status: :ok
        else
          render json: { error: @content.errors }, status: :unprocessable_entity
        end
      end

      private

      def content_params
        params.require(:content).permit(:content)
      end
    end
  end
end
