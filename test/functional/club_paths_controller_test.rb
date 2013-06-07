require 'test_helper'

class ClubPathsControllerTest < ActionController::TestCase
  setup do
    @club_path = club_paths(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:club_paths)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create club_path" do
    assert_difference('ClubPath.count') do
      post :create, club_path: { first_measurement_time: @club_path.first_measurement_time, last_measurement_time: @club_path.last_measurement_time, positions: @club_path.positions }
    end

    assert_redirected_to club_path_path(assigns(:club_path))
  end

  test "should show club_path" do
    get :show, id: @club_path
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @club_path
    assert_response :success
  end

  test "should update club_path" do
    put :update, id: @club_path, club_path: { first_measurement_time: @club_path.first_measurement_time, last_measurement_time: @club_path.last_measurement_time, positions: @club_path.positions }
    assert_redirected_to club_path_path(assigns(:club_path))
  end

  test "should destroy club_path" do
    assert_difference('ClubPath.count', -1) do
      delete :destroy, id: @club_path
    end

    assert_redirected_to club_paths_path
  end
end
