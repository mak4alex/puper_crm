require 'test_helper'

class ClientDealsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get client_deals_index_url
    assert_response :success
  end

  test "should get show" do
    get client_deals_show_url
    assert_response :success
  end

end
