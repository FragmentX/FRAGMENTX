require 'test_helper'

class MaterialTest < ActiveSupport::TestCase
  test "create material without arguments" do
    material = Material.new
    assert material.save
  end
end