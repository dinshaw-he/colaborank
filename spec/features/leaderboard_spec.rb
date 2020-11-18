RSpec.feature 'As a user' do
  let(:homer) { users(:homer)  }
  let(:marge) { users(:marge)  }

  before do
    PointedEvent.destroy_all
    homer.pointed_events.create! type: 'FOO', value: 1000
    marge.pointed_events.create! type: 'FOO', value: 1000
    marge.pointed_events.create! type: 'FOO', value: 1000
  end

  scenario 'I can see the current leaders' do
    visit '/'

    expect(page).to have_content 'Weekly Contest'
    within first('tbody tr') do
      expect(page).to have_content marge.email
      expect(page).to have_content marge.github
      expect(page).to have_content marge.pointed_events.sum(:value)
    end
  end
end
