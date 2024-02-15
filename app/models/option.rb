class Option < ApplicationRecord
  has_many :story_options
  has_many :stories, through: :story_options
end
