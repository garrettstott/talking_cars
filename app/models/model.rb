class Model < ApplicationRecord

	extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :make

  has_many :forums
  has_many :favorites, as: :favoritable

  def self.search(term) 
    where('lower(name) LIKE ?', "%#{term}%")
  end 

end
