require 'rails_helper'

RSpec.describe PointedEventCreator do
  subject(:service) { described_class.new }

  let(:homer) { users(:homer) }
  let(:marge) { users(:marge) }

  describe '#call' do
    context 'when successful' do
      let(:params) do
        {
          github_handles: [marge.github, homer.github],
          type: 'PR_APPROVAL'
        }
      end

      context 'with a PR_APPROVAL' do
        it 'creates single pointed event for user via github handle' do
          expect {
            service.call(params)
          }.to change { marge.pointed_events.count }.by 1
        end

      end

      context 'with a PR_COAUTHORS' do
        let(:params) do
          {
            emails: [homer.email, marge.email],
            type: 'PR_COAUTHORS'
          }
        end

        it 'creates pointed events for each email' do
          expect {
            service.call(params)
          }.to change { marge.pointed_events.count }.by 1
          expect {
            service.call(params)
          }.to change { homer.pointed_events.count }.by 1
        end
      end
    end
  end
end
