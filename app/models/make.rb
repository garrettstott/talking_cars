class Make < ApplicationRecord

  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :favorites, as: :favoritable
  has_many :models
end
