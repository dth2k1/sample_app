require "test_helper"

class StacticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get stactic_pages_home_url
    assert_response :success
  end

  test "should get help" do
    get stactic_pages_help_url
    assert_response :success
  end
end
