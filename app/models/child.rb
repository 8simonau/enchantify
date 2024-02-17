class Child < ApplicationRecord
  belongs_to :user
  has_many :stories

  has_one_attached :avatar

  validates :first_name, presence: true
  validates :birth_date, presence: true

  def age
    (Date.current() - self.birth_date).to_i / 365
  end
end
