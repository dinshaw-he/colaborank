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

    visit '/'
  end

  scenario 'I see the chart', :js do
    expect(page).to have_css '.highcharts-root'
    expect(page).to have_content I18n.t('views.home_page.chart_explanation')
  end

  scenario 'I can see the current leaders' do
    expect(page).to have_content 'Weekly Contest'
    expect(page).to have_content I18n.l(Date.today.beginning_of_week, format: :contest_dates)
    within first('tbody tr') do
      expect(page).to have_content marge.email
      expect(page).to have_content marge.github
      expect(page).to have_content number_with_delimiter(
        marge.pointed_events.this_week.sum(:value)
      )
    end
  end

  scenario 'I can click through the the PointedEvent index page' do
    expect(page).to have_content 'Totals'
    within '.totals .total' do
      click_on number_with_delimiter(PointedEvent.count)
    end
    expect(page).to have_current_path pointed_events_path
  end
end
