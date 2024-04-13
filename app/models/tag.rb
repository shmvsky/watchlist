class Tag < ApplicationRecord
  has_many :film_tags
  has_many :films, through: :film_tags
end
