require 'test_helper'

class BallLandingItemsControllerTest < ActionController::TestCase
  setup do
    @ball_landing_item = ball_landing_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ball_landing_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ball_landing_item" do
    assert_difference('BallLandingItem.count') do
      post :create, ball_landing_item: { ball_landing_id: @ball_landing_item.ball_landing_id, shot_id: @ball_landing_item.shot_id }
    end

    assert_redirected_to ball_landing_item_path(assigns(:ball_landing_item))
  end

  test "should show ball_landing_item" do
    get :show, id: @ball_landing_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ball_landing_item
    assert_response :success
  end

  test "should update ball_landing_item" do
    put :update, id: @ball_landing_item, ball_landing_item: { ball_landing_id: @ball_landing_item.ball_landing_id, shot_id: @ball_landing_item.shot_id }
    assert_redirected_to ball_landing_item_path(assigns(:ball_landing_item))
  end

  test "should destroy ball_landing_item" do
    assert_difference('BallLandingItem.count', -1) do
      delete :destroy, id: @ball_landing_item
    end

    assert_redirected_to ball_landing_items_path
  end
end
