class Child < ApplicationRecord
  belongs_to :user
  has_many :stories

  validates :first_name, presence: true
  validates :birth_date, presence: true
end
