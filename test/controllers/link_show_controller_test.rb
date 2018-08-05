require 'test_helper'

class LinkShowControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get link_show_show_url
    assert_response :success
  end

end
