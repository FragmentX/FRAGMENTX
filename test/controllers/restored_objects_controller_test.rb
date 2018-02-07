require 'test_helper'

class RestoredObjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get restored_objects_index_url
    assert_response :success
  end

  test "should get create" do
    get restored_objects_create_url
    assert_response :success
  end

  test "should get new" do
    get restored_objects_new_url
    assert_response :success
  end

  test "should get update" do
    get restored_objects_update_url
    assert_response :success
  end

  test "should get edit" do
    get restored_objects_edit_url
    assert_response :success
  end

  test "should get show" do
    get restored_objects_show_url
    assert_response :success
  end

  test "should get destroy" do
    get restored_objects_destroy_url
    assert_response :success
  end

end
