require 'test_helper'

class LiveXyzsControllerTest < ActionController::TestCase
  setup do
    @live_xyz = live_xyzs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:live_xyzs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create live_xyz" do
    assert_difference('LiveXyz.count') do
      post :create, live_xyz: { time: @live_xyz.time, x: @live_xyz.x, y: @live_xyz.y, z: @live_xyz.z }
    end

    assert_redirected_to live_xyz_path(assigns(:live_xyz))
  end

  test "should show live_xyz" do
    get :show, id: @live_xyz
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @live_xyz
    assert_response :success
  end

  test "should update live_xyz" do
    put :update, id: @live_xyz, live_xyz: { time: @live_xyz.time, x: @live_xyz.x, y: @live_xyz.y, z: @live_xyz.z }
    assert_redirected_to live_xyz_path(assigns(:live_xyz))
  end

  test "should destroy live_xyz" do
    assert_difference('LiveXyz.count', -1) do
      delete :destroy, id: @live_xyz
    end

    assert_redirected_to live_xyzs_path
  end
end
