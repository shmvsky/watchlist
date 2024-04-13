['комедия', 'боевик', 'триллер', 'сериал', 'драма'].each do |tag_name|
	Tag.create(name: tag_name)
end

green_book = Film.new(title: 'Зелёная книга', rate: 9)
green_book.author = Author.create(name: 'Питер Фаррелли')
green_book.tags << Tag.where(name: 'комедия').first
green_book.tags << Tag.create(name: 'биография')
green_book.save

bandit_film = Film.new(title: 'Бандит', rate: 7)
bandit_film.author = Author.create(name: 'Аллан Ангар')
bandit_film.tags << Tag.where(name: 'драма').first
bandit_film.tags << Tag.where(name: 'триллер').first
bandit_film.status = 'planned'
bandit_film.save
