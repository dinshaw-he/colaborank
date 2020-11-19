class SiteController < ApplicationController
  Ranking = Struct.new :breakdown, :email, :github, :total, keyword_init: true

  def index
    point_events = PointedEvent.this_week.select('user_id, sum(value) as total').group('user_id').order('total desc')

    @rankings = point_events.map do |pointed_event|
      user = User.find pointed_event.user_id
      Ranking.new(
        email: user.email,
        github: user.github,
        total: pointed_event.total,
        breakdown: user.pointed_events.this_week.group(:type).sum(:value)
      )
    end
  end
end
