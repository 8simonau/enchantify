class Story < ApplicationRecord
  belongs_to :child
  belongs_to :voice

  has_many :story_options, dependent: :destroy
  has_many :options, through: :story_options

  has_many_attached :pictures
  has_one_attached :audio

  validates :playcount, presence: true

  # helper to get options
  def options_hash
    return Hash[options.collect { |o| [o.category, o.name] }]
  end
end
