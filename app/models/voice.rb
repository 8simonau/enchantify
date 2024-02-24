class Voice < ApplicationRecord
  belongs_to :user
  has_many :stories
  has_one_attached :audio

  validates :name, presence: true
  validates :audio, presence: { message: "sample must be recorded" }
end
