require 'test_helper'

class GenerateControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get generate_index_url
    assert_response :success
  end

end
