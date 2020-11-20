require 'rails_helper'

RSpec.describe "PointedEvents", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/pointed_events/index"
      expect(response).to have_http_status(:success)
    end
  end

end
