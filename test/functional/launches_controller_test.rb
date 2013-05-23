require 'test_helper'

class LaunchesControllerTest < ActionController::TestCase
  setup do
    @launch = launches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:launches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create launch" do
    assert_difference('Launch.count') do
      post :create, launch: { attack_angle: @launch.attack_angle, ball_horizontal_angle: @launch.ball_horizontal_angle, ball_speed: @launch.ball_speed, ball_vertical_angle: @launch.ball_vertical_angle, club_path: @launch.club_path, club_speed: @launch.club_speed, dynamic_loft: @launch.dynamic_loft, face_angle: @launch.face_angle, smash_factor: @launch.smash_factor, spin_axis_horizontal: @launch.spin_axis_horizontal, spin_axis_vertical: @launch.spin_axis_vertical, spin_rate: @launch.spin_rate, swing_plane_horizontal: @launch.swing_plane_horizontal, swing_plane_vertical: @launch.swing_plane_vertical }
    end

    assert_redirected_to launch_path(assigns(:launch))
  end

  test "should show launch" do
    get :show, id: @launch
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @launch
    assert_response :success
  end

  test "should update launch" do
    put :update, id: @launch, launch: { attack_angle: @launch.attack_angle, ball_horizontal_angle: @launch.ball_horizontal_angle, ball_speed: @launch.ball_speed, ball_vertical_angle: @launch.ball_vertical_angle, club_path: @launch.club_path, club_speed: @launch.club_speed, dynamic_loft: @launch.dynamic_loft, face_angle: @launch.face_angle, smash_factor: @launch.smash_factor, spin_axis_horizontal: @launch.spin_axis_horizontal, spin_axis_vertical: @launch.spin_axis_vertical, spin_rate: @launch.spin_rate, swing_plane_horizontal: @launch.swing_plane_horizontal, swing_plane_vertical: @launch.swing_plane_vertical }
    assert_redirected_to launch_path(assigns(:launch))
  end

  test "should destroy launch" do
    assert_difference('Launch.count', -1) do
      delete :destroy, id: @launch
    end

    assert_redirected_to launches_path
  end
end
