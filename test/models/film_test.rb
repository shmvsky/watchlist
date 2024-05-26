require "test_helper"

# test/models/film_test.rb
require "test_helper"

class FilmTest < ActiveSupport::TestCase
  test "should not save film without title" do
    film = Film.new(rate: 5, status: :watched, author: authors(:one))
    assert_raises(ActiveRecord::NotNullViolation, "Saved the film without a title") do
      film.save
    end
  end

  test "should not save film with duplicate title" do
    film1 = films(:one)
    film2 = Film.new(title: film1.title, rate: 4, status: :planned, author: authors(:two))
    assert_raises(ActiveRecord::RecordNotUnique, "Saved the film with a duplicate title") do
      film2.save
    end
  end

  test "should not save film without rate" do
    film = Film.new(title: "Unique Title", status: :watched, author: authors(:one))
    assert_raises(ActiveRecord::NotNullViolation, "Saved the film without a rate") do
      film.save
    end
  end

  test "should belong to an author" do
    film = films(:one)
    assert_respond_to film, :author
  end

  test "should have many film_tags" do
    film = films(:one)
    assert_respond_to film, :film_tags
  end

  test "should have many tags through film_tags" do
    film = films(:one)
    assert_respond_to film, :tags
  end

  test "should have correct enum statuses" do
    assert_equal "watched", films(:one).status
    assert_equal "planned", films(:two).status
  end

  test "should have the correct tags associated" do
    film = films(:one)
    tag = tags(:one)
    assert_includes film.tags, tag
  end
end

