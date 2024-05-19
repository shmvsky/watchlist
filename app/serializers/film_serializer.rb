class FilmSerializer < ActiveModel::Serializer
  attributes :id, :title, :note, :rate, :status, :author_id
  has_many :tags
end
