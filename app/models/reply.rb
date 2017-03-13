class Reply < ApplicationRecord
  validates_presence_of :body
  belongs_to :post, counter_cache: true
  belongs_to :user, counter_cache: true

 	has_many :post_images

  after_save do
    post.update_attribute(:updated_at, Time.now)
  end

  def self.search(term)
  	where('lower(body) LIKE ? ', "%#{term}%")
  end 
end
