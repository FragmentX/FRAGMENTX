require 'test_helper'

class CollectionTest < ActiveSupport::TestCase

  long_description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus in est nec ex condimentum molestie. Nam luctus ex vitae consectetur lacinia. Nunc non augue fermentum, aliquam ex in, lobortis orci. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vel augue tincidunt, fringilla magna id, gravida elit. Cras id ante blandit, rutrum justo vel, lobortis dolor. Phasellus urna tortor, scelerisque sed ligula eu, vestibulum dapibus nulla. Integer vitae metus non enim luctus feugiat id metus."

  test "create collection without arguments" do
    collection = Collection.new
    assert_not collection.save
  end

  test "create collection without title," do
    collection = Collection.new( user_id: 1, description: "Lorem ipsum dolor sit amet")
    assert_not collection.save
  end

  test "create collection with short title," do
    collection = Collection.new(title: "t", description: "Lorem ipsum dolor sit amet")
    assert_not collection.save
  end

  test "create collection with long description" do
    collection = Collection.new(title: "title-test", user_id: 1, description: long_description)
    assert_not collection.save
  end

  test "create collection without description," do
    collection = Collection.new(title: "title-test", user_id: 1)
    assert collection.save
  end

  test "create collection with title," do
    collection = Collection.new(title: "title-test", user_id: 1, description: "Lorem ipsum dolor sit amet")
    assert collection.save
  end
end