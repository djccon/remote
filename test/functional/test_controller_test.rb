require 'test_helper'

class TestControllerTest < ActionController::TestCase
  test "should get send_command" do
    get :send_command
    assert_response :success
  end

  test "should get get_commands" do
    get :get_commands
    assert_response :success
  end

end
