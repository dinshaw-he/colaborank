class PointedEventsController < ApplicationController
  def index
    @q = PointedEvent.ransack(params[:q])
    @q.sorts = 'created_at desc' if @q.sorts.empty?
    @pointed_events = @q.result(distinct: true).page params[:page]
  end
end
