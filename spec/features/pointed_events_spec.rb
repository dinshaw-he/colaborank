RSpec.feature 'As a user' do
  let(:user) { users(:homer) }

  let!(:event_1) do
    PointedEventCreator.new.call(
      { type: 'PR_APPROVAL', github_handles: [user.github] }
    )
  end

  before do
    visit pointed_events_path
  end

  scenario 'I can see all PointedEvents' do
    within first('tbody tr') do
      expect(page).to have_content PointedEvent.last.type
    end
  end
end
