class Voice < ApplicationRecord
  belongs_to :user
  has_many :stories

  validates :name, presence: true
  validates :token, presence: true
end
