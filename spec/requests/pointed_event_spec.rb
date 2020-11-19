require "rails_helper"

RSpec.describe 'PointedEvent' do
  let(:headers) do
    { ACCEPT: "application/json" }
  end

  describe 'POST /pointed_events' do
    before do
      post '/api/v1/pointed_events', params: create_params, headers: headers
    end

    context 'with a PR_APPROVAL' do
      let(:user) { users(:homer) }
      let(:create_params) do
        {
          pointed_event: {
            user: user.github,
            type: 'PR_APPROVAL',
            value: 1000
          }
        }
      end

      it 'creates a PointedEvent' do
        body = JSON.parse(response.body)

        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:created)
        expect(body['message']).to eq I18n.t('api.v1.pointed_events.create.success')
        expect(body['ids']).to be_a Array
      end
    end

    context 'with a PR_COAUTHORS' do
      let(:homer) { users(:homer) }
      let(:marge) { users(:marge) }
      let(:create_params) do
        {
          pointed_event: {
            emails: [homer.email, marge.email],
            type: 'PR_COAUTHORS',
            value: 1000
          }
        }
      end

      it 'creates a PointedEvent' do
        body = JSON.parse(response.body)

        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:created)
        expect(body['message']).to eq I18n.t('api.v1.pointed_events.create.success')
        expect(body['ids']).to be_a Array
      end
    end
  end

  describe 'GET /pointed_events' do
    include_context 'populate pointed events'

    let(:start_date) do
      PointedEvent.order('created_at asc').first.created_at.to_s(:db_date)
    end
    let(:range) { (start_date.to_date..Date.today) }
    let(:expected_payload) do
      users.map do |user|
        {
          'email' => user.email,
          'points' => range.map do |date|
            PointedEvent.where(created_at: (date - 5.days)..date).sum(:value)
          end
        }
      end
    end

    before do
      get '/api/v1/pointed_events'
    end

    it 'returns the payload for a line chart' do
      body = JSON.parse(response.body)

      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response).to have_http_status(:ok)
      expect(body['data']).to eq expected_payload
    end
  end
end
