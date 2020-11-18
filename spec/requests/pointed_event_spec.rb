require "rails_helper"

RSpec.describe 'PointedEvent' do
  let(:user) { users(:homer) }
  let(:create_params) do
    {
      pointed_event: {
        email: user.email,
        type: 'PR_APPROVAL',
        value: 1000
      }
    }
  end

  it 'creates a PointedEvent' do
    headers = { ACCEPT: "application/json" }
    post "/api/v1/pointed_events.json", params: create_params

    body = JSON.parse(response.body)

    expect(response.content_type).to eq("application/json; charset=utf-8")
    expect(response).to have_http_status(:created)
    expect(body['message']).to eq I18n.t('api.v1.pointed_events.create.success')
    expect(body['id']).not_to be_nil
  end
end
