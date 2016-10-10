require 'test_helper'

class DealsControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get deals_controller_new_url
    assert_response :success
  end

  test "should get create" do
    get deals_controller_create_url
    assert_response :success
  end

end
