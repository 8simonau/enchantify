class Option < ApplicationRecord
  has_many :story_options
  has_many :stories, through: :story_options

  has_one_attached :picture

  validates :category, presence: true
  validates :name, presence: true
  validates :description, presence: true
end
