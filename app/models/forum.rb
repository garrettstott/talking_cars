class Forum < ApplicationRecord
  belongs_to :model
  has_many :posts
  has_many :favorites, as: :favoritable

  def number_of_posts
    self.posts.count
  end

  def number_of_replies
    self.posts.joins("JOIN replies ON replies.post_id = posts.id").length
  end

  def last_post
    self.posts.order(created_at: :asc).last
  end
end
