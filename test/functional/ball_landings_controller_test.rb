require 'test_helper'

class BallLandingsControllerTest < ActionController::TestCase
  setup do
    @ball_landing = ball_landings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ball_landings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ball_landing" do
    assert_difference('BallLanding.count') do
      post :create, ball_landing: { carry: @ball_landing.carry, horizontal_angle: @ball_landing.horizontal_angle, side: @ball_landing.side, speed: @ball_landing.speed, time: @ball_landing.time, vertical_angle: @ball_landing.vertical_angle, x: @ball_landing.x, y: @ball_landing.y, z: @ball_landing.z }
    end

    assert_redirected_to ball_landing_path(assigns(:ball_landing))
  end

  test "should show ball_landing" do
    get :show, id: @ball_landing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ball_landing
    assert_response :success
  end

  test "should update ball_landing" do
    put :update, id: @ball_landing, ball_landing: { carry: @ball_landing.carry, horizontal_angle: @ball_landing.horizontal_angle, side: @ball_landing.side, speed: @ball_landing.speed, time: @ball_landing.time, valid: @ball_landing.valid, vertical_angle: @ball_landing.vertical_angle, x: @ball_landing.x, y: @ball_landing.y, z: @ball_landing.z }
    assert_redirected_to ball_landing_path(assigns(:ball_landing))
  end

  test "should destroy ball_landing" do
    assert_difference('BallLanding.count', -1) do
      delete :destroy, id: @ball_landing
    end

    assert_redirected_to ball_landings_path
  end
end
