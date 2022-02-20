module Api
  module V1
    class ContentsController < PrivateController
      load_and_authorize_resource
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

      def content_params
        params.permit(:content)
      end
    end
  end
end
