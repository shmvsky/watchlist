require "test_helper"

# test/models/film_tag_test.rb
require "test_helper"

class FilmTagTest < ActiveSupport::TestCase
  test "should not save film_tag without film_id" do
    film_tag = FilmTag.new(tag: tags(:one))
    assert_not film_tag.save, "Saved the film_tag without a film_id"
  end

  test "should not save film_tag without tag_id" do
    film_tag = FilmTag.new(film: films(:one))
    assert_not film_tag.save, "Saved the film_tag without a tag_id"
  end

  test "should belong to a film" do
    film_tag = film_tags(:one)
    assert_respond_to film_tag, :film
  end

  test "should belong to a tag" do
    film_tag = film_tags(:one)
    assert_respond_to film_tag, :tag
  end
end

