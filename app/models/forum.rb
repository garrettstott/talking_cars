class Forum < ApplicationRecord

  extend FriendlyId
  friendly_id :slugged_candidates, use: :slugged

  belongs_to :model
  has_many :posts
  has_many :favorites, as: :favoritable

  validates_presence_of :category, in: ['General', 'Technical', 'Classifed']
  validates_presence_of :name

  def slugged_candidates
    [
      [self.model.make.name, :name],
      [self.model.make.name, self.model.name, :name]
    ]
  end

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
