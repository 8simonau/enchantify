class Story < ApplicationRecord
  belongs_to :child
  belongs_to :voice

  has_many :story_options
  has_many :options, through: :story_options

  validates :playcount, presence: :true
  validates :is_favorite, presence: :true
  validates :title, presence: :true
  validates :text, presence: :true
end
