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

  def forum_replies_count 
    posts.pluck('replies_count').inject(&:+)
  end 

  def last_post
    self.posts.order(created_at: :asc).last
  end
end
