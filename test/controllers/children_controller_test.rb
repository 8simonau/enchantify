require "test_helper"

class ChildrenControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get children_index_url
    assert_response :success
  end

  test "should get create" do
    get children_create_url
    assert_response :success
  end

  test "should get set_child" do
    get children_set_child_url
    assert_response :success
  end
end
