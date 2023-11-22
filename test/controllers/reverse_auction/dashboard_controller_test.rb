require "test_helper"

class ReverseAuction::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reverse_auction_dashboard_index_url
    assert_response :success
  end
end
