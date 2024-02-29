class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  has_many :children
  has_many :voices
  belongs_to :active_child, class_name: "Child", optional: true

  validates :first_name, presence: true
  validates :last_name, presence: true
end
