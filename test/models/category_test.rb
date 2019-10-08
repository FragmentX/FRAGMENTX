require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "create category without arguments" do
    category = Category.new
    assert_not category.save
  end
end

class CategoryTest < ActiveSupport::TestCase
  test "create category with name" do
    category = Category.new(name: "Glass")
    assert category.save
  end
end