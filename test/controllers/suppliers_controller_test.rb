require 'test_helper'

class SuppliersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get suppliers_index_url
    assert_response :success
  end

  test "should get show" do
    get suppliers_show_url
    assert_response :success
  end

end
