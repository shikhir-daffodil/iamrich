require 'test_helper'

class V1::ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get get_rich_people" do
    get v1_api_get_rich_people_url
    assert_response :success
  end

end
