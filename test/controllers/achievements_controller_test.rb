require "test_helper"

class AchievementsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get achievements_index_url
    assert_response :success
  end
end
