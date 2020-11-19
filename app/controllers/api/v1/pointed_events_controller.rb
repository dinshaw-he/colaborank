module Api
  module V1
    class PointedEventsController < ApplicationController
      skip_before_action :authenticate_user!
      skip_before_action :verify_authenticity_token

      def create
        service = PointedEventCreator.new

        service.call(pointed_event_params) do |result|
          result.success do |payload|
            render json: { message: payload.message, ids: payload.ids },
              status: :created
          end

          result.failure do |error|
            render json: { message: error }, status: :unprocessable_entity
          end
        end
      end

      def index
        data = []
        render json: { data: data }, status: :ok
      end

      private

      def pointed_event_params
        params.require(:pointed_event).permit(
          :user,
          :value,
          :type,
          :description,
          emails: [],
        )
      end
    end
  end
end
