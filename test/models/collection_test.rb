require 'test_helper'

class CollectionTest < ActiveSupport::TestCase

  def_password = 'TestPassword123'
  def_email    = 'testCollection@gmail.com'
  def_name     = 'testCollectionName'

  long_description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus in est nec ex condimentum molestie. Nam luctus ex vitae consectetur lacinia. Nunc non augue fermentum, aliquam ex in, lobortis orci. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vel augue tincidunt, fringilla magna id, gravida elit. Cras id ante blandit, rutrum justo vel, lobortis dolor. Phasellus urna tortor, scelerisque sed ligula eu, vestibulum dapibus nulla. Integer vitae metus non enim luctus feugiat id metus."

  userCollection = User.new(email:def_email,
                    password: def_password,
                    password_confirmation: def_password,
                    name: def_name)
                    userCollection.save

  test "create collection without arguments" do
    collection = Collection.new
    assert_not collection.save
  end

  test "create collection without title," do
    collection = Collection.new( user_id: userCollection.id, description: "Lorem ipsum dolor sit amet")
    assert_not collection.save
  end

  test "create collection with short title," do
    collection = Collection.new(title: "t", user_id: userCollection.id, description: "Lorem ipsum dolor sit amet")
    assert_not collection.save
  end

  test "create collection with long description" do
    collection = Collection.new(title: "title-test", user_id: userCollection.id, description: long_description)
    assert_not collection.save
  end

  test "create collection without description," do
    collection = Collection.new(title: "title-test", user_id: userCollection.id)
    assert collection.save
  end

  test "create collection with title," do
    collection = Collection.new(title: "title-test", user_id: userCollection.id, description: "Lorem ipsum dolor sit amet")
    assert collection.save
  end
end