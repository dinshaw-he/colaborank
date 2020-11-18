module Api
  module V1
    class PointedEventsController < ApplicationController
      skip_before_action :authenticate_user!
      skip_before_action :verify_authenticity_token

      def create
        user = User.find_by! github: user_params[:user]
        pointed_event = PointedEvent.new pointed_event_params.merge(user: user)

        message, id = if pointed_event.save
          [t('.success'), pointed_event.id ]
        else
          [pointed_event.errors.full_messages, nil]
        end

        render json: { message: message, id: id }, status: :created
      end

      private

      def user_params
        params.require(:pointed_event).permit :user
      end

      def pointed_event_params
        params.require(:pointed_event).permit(
          :value,
          :type,
          :description
        )
      end
    end
  end
end
