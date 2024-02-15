class Option < ApplicationRecord
  has_many :story_options
  has_many :stories, through: :story_options

  has_one_attached :picture

  validates :type, presence: :true
  validates :name, presence: :true
end
