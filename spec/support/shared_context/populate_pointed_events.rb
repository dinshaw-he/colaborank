require 'rails_helper'

RSpec.shared_context 'populate pointed events' do
  let(:homer) { users(:homer) }
  let(:marge) { users(:marge) }
  let(:bart) { users(:bart) }

  before do
    travel_to 6.days.ago do
      homer.pointed_events.create type: 'PR_APPROVAL', value: 1000
      marge.pointed_events.create type: 'PR_APPROVAL', value: 1000
      bart.pointed_events.create type: 'PR_APPROVAL', value: 1000
    end

    travel_to 5.days.ago do
      homer.pointed_events.create type: 'PR_APPROVAL', value: 1000
      marge.pointed_events.create type: 'PR_APPROVAL', value: 1000
    end

    travel_to 4.days.ago do
      marge.pointed_events.create type: 'PR_APPROVAL', value: 1000
      bart.pointed_events.create type: 'PR_APPROVAL', value: 1000
    end

    travel_to 3.days.ago do
      marge.pointed_events.create type: 'PR_APPROVAL', value: 1000
      bart.pointed_events.create type: 'PR_APPROVAL', value: 1000
    end

    travel_to 2.days.ago do
      marge.pointed_events.create type: 'PR_APPROVAL', value: 1000
    end

    travel_to 1.days.ago do
      marge.pointed_events.create type: 'PR_APPROVAL', value: 1000
    end
  end
end
