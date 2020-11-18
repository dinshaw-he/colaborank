class SiteController < ApplicationController
  Ranking = Struct.new :email, :total, keyword_init: true
  def index
    point_events = PointedEvent.select('user_id, sum(value) as total').group('user_id').order('total desc')

    @rankings = point_events.map do |pointed_event|
      Ranking.new(
        email: User.find(pointed_event.user_id).email,
        total: pointed_event.total
      )
    end
  end
end
