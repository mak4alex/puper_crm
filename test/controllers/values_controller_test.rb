require 'test_helper'

class ValuesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get values_create_url
    assert_response :success
  end

end
