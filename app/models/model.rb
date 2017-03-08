class Model < ApplicationRecord

	extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :make

  has_many :forums
  has_many :favorites, as: :favoritable
end
