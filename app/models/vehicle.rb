class Vehicle < ApplicationRecord
  belongs_to :user

  validates_presence_of :year, :make, :model
  
end
