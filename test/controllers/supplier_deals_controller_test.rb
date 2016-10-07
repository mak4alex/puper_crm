require 'test_helper'

class SupplierDealsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get supplier_deals_index_url
    assert_response :success
  end

  test "should get show" do
    get supplier_deals_show_url
    assert_response :success
  end

end
