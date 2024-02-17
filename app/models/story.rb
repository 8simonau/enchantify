class Story < ApplicationRecord
  belongs_to :child
  belongs_to :voice

  has_many :story_options
  has_many :options, through: :story_options

  has_many_attached :pictures
  has_one_attached :audio

  validates :playcount, presence: true
  # validates :is_favorite, presence: true
  validates :title, presence: true
  validates :text, presence: true
end
