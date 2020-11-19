RSpec.feature 'As a user' do
  include ActionView::Helpers::NumberHelper

  let(:homer) { users(:homer)  }
  let(:marge) { users(:marge)  }

  before do
    PointedEvent.destroy_all
    homer.pointed_events.create! type: 'FOO', value: 1000
    marge.pointed_events.create! type: 'FOO', value: 1000
    marge.pointed_events.create! type: 'FOO', value: 1000

    travel_to 2.weeks.ago do
      homer.pointed_events.create! type: 'FOO', value: 1000
      marge.pointed_events.create! type: 'FOO', value: 1000
      marge.pointed_events.create! type: 'FOO', value: 1000
    end
  end

  scenario 'I can see the current leaders' do
    visit '/'

    expect(page).to have_content 'Weekly Contest'
    expect(page).to have_content Date.today.beginning_of_week.to_s(:short)
    within first('tbody tr') do
      expect(page).to have_content marge.email
      expect(page).to have_content marge.github
      expect(page).to have_content number_with_delimiter(
        marge.pointed_events.this_week.sum(:value)
      )
    end
  end
end
