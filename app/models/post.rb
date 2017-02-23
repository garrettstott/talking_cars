class Post < ApplicationRecord
  belongs_to :forum
  belongs_to :user
  has_many :replies

  def last_reply
    self.replies.order(created_at: :asc).last
  end
end
