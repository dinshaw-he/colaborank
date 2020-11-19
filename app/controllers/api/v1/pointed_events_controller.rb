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
        start_date = PointedEvent.minimum(:created_at).to_date
        range = start_date..Date.today
        chart_data = User.all.map do |user|
          {
            email: user.email,
            points: range.map do |date|
              user.pointed_events.where(created_at: (date - 5.days)..date).sum(:value)
            end
          }
        end

        render json: { chart_data: chart_data, start_date: start_date }, status: :ok
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
