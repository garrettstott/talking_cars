class Vehicle < ApplicationRecord
  belongs_to :user

  validates_presence_of :make, :year
end
