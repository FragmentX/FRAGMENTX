require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "create category without arguments" do
    material = Category.new
    assert_not material.save
  end
end

class CategoryTest < ActiveSupport::TestCase
  test "create category with name" do
    material = Category.new(name: "Glass")
    assert material.save
  end
end