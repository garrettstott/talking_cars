class Make < ApplicationRecord

  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :models 
end
