class Author < ApplicationRecord
	has_many :films, dependent: :delete_all

	def films_cnt
		films.count		
	end
	
	def avg_rating
		films.average(:rate) || 0.0		
	end

	def as_json(options = {})
    	super(options.merge(methods: [:films_cnt, :avg_rating]))
  	end

end
