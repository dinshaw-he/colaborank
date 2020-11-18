module Api
  module V1
    class PointedEventsController < ApplicationController
      skip_before_action :authenticate_user!

      def create
        user = User.find_by! email: email_params[:email]
        pointed_event = PointedEvent.new pointed_event_params.merge(user: user)

        message, id = if pointed_event.save
          [t('.success'), pointed_event.id ]
        else
          [pointed_event.errors.full_messages, nil]
        end

        render json: { message: message, id: id }, status: :created
      end

      private

      def email_params
        params.require(:pointed_event).permit :email
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
