require 'rails_helper'

RSpec.describe PointedEvent, type: :model do
  let(:user) { users(:homer) }

  it { is_expected.to belong_to :user }
  it { is_expected.to validate_numericality_of :value }
  it { is_expected.to validate_presence_of :type }

  describe '.since(date)' do
    let(:expected_count) do
      described_class.where(created_at: start_time..Time.zone.now).count
    end

    let(:start_time) { 5.days.ago.beginning_of_day }

    before do
      travel_to 6.days.ago do
        user.pointed_events.create type: 'PR_APPROVAL', value: 100
      end

      travel_to 3.days.ago do
        user.pointed_events.create type: 'PR_APPROVAL', value: 100
      end

      travel_to 2.days.ago do
        user.pointed_events.create type: 'PR_APPROVAL', value: 100
      end
    end

    it 'returns only records created within the time window' do
      expect(described_class.since(start_time).count).to eq expected_count
    end
  end
end
