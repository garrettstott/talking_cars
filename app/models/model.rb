class Model < ApplicationRecord
  belongs_to :make

  has_many :forums
  has_many :favorites, as: :favoritable
end
