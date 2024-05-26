require "test_helper"

# test/models/author_test.rb
require "test_helper"

class AuthorTest < ActiveSupport::TestCase
  test "should not save author without name" do
    author = Author.new
    assert_raises(ActiveRecord::NotNullViolation, "Saved the author without a name") do
      author.save
    end
  end

  test "should not save author with duplicate name" do
    author1 = Author.create(name: "Unique Name")
    author2 = Author.new(name: "Unique Name")
    assert_raises(ActiveRecord::RecordNotUnique, "Saved the author with a duplicate name") do
      author2.save
    end
  end

  test "should have many films" do
    author = authors(:one)
    assert_respond_to author, :films
  end
end

