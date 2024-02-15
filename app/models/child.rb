class Child < ApplicationRecord
  belongs_to :user
  has_many :stories

  has_one_attached :avatar

  validates :first_name, presence: true
  validates :birth_date, presence: true
end
