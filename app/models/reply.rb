class Reply < ApplicationRecord
  validates_presence_of :body
  belongs_to :post, counter_cache: true
  belongs_to :user, counter_cache: true

  after_save do
    post.update_attribute(:updated_at, Time.now)
  end
end
