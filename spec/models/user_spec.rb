require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many :pointed_events }
  it { is_expected.to validate_presence_of :github }
end
