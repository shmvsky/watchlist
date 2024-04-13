class Film < ApplicationRecord

  enum status: {watched: 0, planned: 1, dropped: 2}

  belongs_to :author

  has_many :film_tags
  has_many :tags, through: :film_tags
end
