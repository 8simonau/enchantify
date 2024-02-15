class Child < ApplicationRecord
  belongs_to :user
  has_many :stories
end
