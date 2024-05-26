require "test_helper"

# test/models/tag_test.rb
require "test_helper"

class TagTest < ActiveSupport::TestCase
  test "should not save tag without name" do
    tag = Tag.new
    assert_raises(ActiveRecord::NotNullViolation, "Saved the tag without a name") do
      assert_not tag.save
    end 
  end

  test "should not save tag with duplicate name" do
    tag1 = tags(:one)
    tag2 = Tag.new(name: tag1.name)
    assert_raises(ActiveRecord::RecordNotUnique, "Saved the tag with a duplicate name") do
      tag2.save
    end 
  end

  test "should have many film_tags" do
    tag = tags(:one)
    assert_respond_to tag, :film_tags
  end

 
  test "should have many films through film_tags" do
    tag = tags(:one)
    assert_respond_to tag, :films
  end

  
  test "should have the correct films associated" do
    tag = tags(:one)
    film = films(:one)
    assert_includes tag.films, film
  end
end

