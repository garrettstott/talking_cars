class Post < ApplicationRecord

  extend FriendlyId
  friendly_id :slugged_candidates, use: :slugged

  belongs_to :forum
  belongs_to :user

  has_many :replies
  has_many :favorites, as: :favoritable

  def slugged_candidates
    [
      [self.forum.model.name, self.forum.category, :subject],
      [self.forum.model.make.name, self.forum.model.name, self.forum.category, :subject]
    ]
  end

  def last_reply
    self.replies.order(created_at: :asc).last
  end

  def number_of_replies
    self.replies.length
  end
end
