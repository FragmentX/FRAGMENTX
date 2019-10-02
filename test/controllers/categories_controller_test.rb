require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "show categories index" do
    get '/categories'
    assert_response :success
  end
end