require 'test_helper'

class MaterialTest < ActiveSupport::TestCase
  test "create material without arguments" do
    material = Material.new
    assert_not material.save
  end
end

class MaterialTest < ActiveSupport::TestCase
  test "create material with name" do
    material = Material.new(name: "Glass")
    assert material.save
  end
end