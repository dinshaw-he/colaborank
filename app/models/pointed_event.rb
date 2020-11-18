class PointedEvent < ApplicationRecord
  self.inheritance_column = :_type_disabled

  belongs_to :user

  validates :type, presence: true
  validates :value, presence: true, numericality: true
end
