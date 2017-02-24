class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :make, optional: true
  belongs_to :model, optional: true
  belongs_to :forum, optional: true
  belongs_to :post, optional: true
end
