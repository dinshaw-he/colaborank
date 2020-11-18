require 'rails_helper'

RSpec.describe PointedEvent, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_numericality_of :value }
  it { is_expected.to validate_presence_of :type }
end
