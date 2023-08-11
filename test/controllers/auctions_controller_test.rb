require "test_helper"

class AuctionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get auctions_new_url
    assert_response :success
  end

  test "should get edit" do
    get auctions_edit_url
    assert_response :success
  end
end
