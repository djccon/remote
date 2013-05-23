require 'test_helper'

class LaunchItemsControllerTest < ActionController::TestCase
  setup do
    @launch_item = launch_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:launch_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create launch_item" do
    assert_difference('LaunchItem.count') do
      post :create, launch_item: { launch_id: @launch_item.launch_id, shot_id: @launch_item.shot_id }
    end

    assert_redirected_to launch_item_path(assigns(:launch_item))
  end

  test "should show launch_item" do
    get :show, id: @launch_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @launch_item
    assert_response :success
  end

  test "should update launch_item" do
    put :update, id: @launch_item, launch_item: { launch_id: @launch_item.launch_id, shot_id: @launch_item.shot_id }
    assert_redirected_to launch_item_path(assigns(:launch_item))
  end

  test "should destroy launch_item" do
    assert_difference('LaunchItem.count', -1) do
      delete :destroy, id: @launch_item
    end

    assert_redirected_to launch_items_path
  end
end
