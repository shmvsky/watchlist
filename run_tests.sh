export POSTGRES_USER=postgres
export POSTGRES_PASSWORD=password
export POSTGRES_HOST=localhost

rails test test/models/author_test.rb
rails test test/models/film_test.rb
rails test test/models/film_tag_test.rb
rails test test/models/tag_test.rb
