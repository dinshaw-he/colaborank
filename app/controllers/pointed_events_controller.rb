class PointedEventsController < ApplicationController
  def index
    @q = PointedEventsCollection.new(params: search_params).q
    @q.sorts = 'created_at desc' if @q.sorts.empty?
    @pointed_events = @q.result(distinct: true).includes(:user).page params[:page]
  end

  private

  def search_params
    return {} unless params[:q]

    params.require(:q).permit(
      :user_id_eq,
      :type_eq,
      :repo_eq,
      :user_email_eq,
      :created_at_gteq,
      :created_at_lteq,
    )
  end
end

