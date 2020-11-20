require 'rails_helper'

RSpec.describe "PointedEvents", type: :request do
  let(:user) { users(:homer) }

  before do
    travel_to 1.week.ago do
      PointedEventCreator.new.call({ type: 'PR_APPROVAL', github_handles: [user.github] } )
    end

    travel_to 3.days.ago do
      PointedEventCreator.new.call({ type: 'PR_COAUTHORS', emails: [user.email] } )
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/pointed_events/index"
      expect(response).to have_http_status(:success)
    end
  end

end
