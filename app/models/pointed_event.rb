class PointedEvent < ApplicationRecord
  self.inheritance_column = :_type_disabled

  VALUES = {
    'PR_APPROVAL' => 1000,
    'PR_COAUTHORS' => 1000
  }.freeze

  belongs_to :user

  validates :type, presence: true
  validates :value, presence: true, numericality: true

  scope :this_week, -> { since Date.today.beginning_of_week.to_time }
  scope :since, lambda { |start_time|  where('created_at >= ?', start_time) }
  scope :by_type, lambda { |type| where(type: type) }
  scope :by_repo, lambda { |repo| where(repo: repo) }
end
