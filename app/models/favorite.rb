class Favorite < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :favoritable, polymorphic: true, counter_cache: true
end
