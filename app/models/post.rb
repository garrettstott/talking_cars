class Post < ApplicationRecord

  extend FriendlyId
  friendly_id :subject, use: :slugged

  belongs_to :forum, counter_cache: true
  belongs_to :user, counter_cache: true

  has_many :replies
  has_many :favorites, as: :favoritable

  def last_reply
    self.replies.order(created_at: :asc).last
  end

  def self.search(term)
  	where('lower(subject) LIKE ? OR lower(body) LIKE ?', "%#{term}%", "%#{term}%")
  end 

end
