RSpec.feature 'As a user' do
  let(:user) { users(:homer)  }

  before do
    login_as user
  end

  scenario 'I can see the current leaders' do
    visit '/'
    expect(page).to have_content 'Weekly Contest'
  end
end
