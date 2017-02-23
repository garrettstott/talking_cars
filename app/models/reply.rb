class Reply < ApplicationRecord
  validates_presence_of :body
  belongs_to :post
  belongs_to :user

  after_save do
    post.update_attribute(:updated_at, Time.now)
  end
end
