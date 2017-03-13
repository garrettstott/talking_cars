class PostImage < ApplicationRecord
  belongs_to :post
  belongs_to :reply

  mount_uploader :image, PostImageUploader
end
