class SiteController < ApplicationController
  Ranking = Struct.new :email, :github, :total, keyword_init: true

  def index
    point_events = PointedEvent.select('user_id, sum(value) as total').group('user_id').order('total desc')

    @rankings = point_events.map do |pointed_event|
      user = User.find pointed_event.user_id
      Ranking.new(
        email: user.email,
        github: user.github,
        total: pointed_event.total
      )
    end
  end
end
