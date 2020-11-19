class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :pointed_events, dependent: :destroy

  validates :github, presence: true
end
