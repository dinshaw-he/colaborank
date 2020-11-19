class PointedEvent < ApplicationRecord
  self.inheritance_column = :_type_disabled

  VALUES = {
    'PR_APPROVAL' => 1000,
    'PR_COAUTHORS' => 1000
  }.freeze

  belongs_to :user

  validates :type, presence: true
  validates :value, presence: true, numericality: true

  scope :since, lambda { |start_time|  where(created_at: start_time..Time.zone.now) }
end
