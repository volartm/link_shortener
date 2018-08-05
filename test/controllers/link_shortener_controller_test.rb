require 'test_helper'

class LinkShortenerControllerTest < ActionDispatch::IntegrationTest
  test "should get shorten" do
    get link_shortener_shorten_url
    assert_response :success
  end

end
