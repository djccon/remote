require 'test_helper'

class BallFlightItemsControllerTest < ActionController::TestCase
  setup do
    @ball_flight_item = ball_flight_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ball_flight_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ball_flight_item" do
    assert_difference('BallFlightItem.count') do
      post :create, ball_flight_item: { ball_flight_id: @ball_flight_item.ball_flight_id, shot_id: @ball_flight_item.shot_id }
    end

    assert_redirected_to ball_flight_item_path(assigns(:ball_flight_item))
  end

  test "should show ball_flight_item" do
    get :show, id: @ball_flight_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ball_flight_item
    assert_response :success
  end

  test "should update ball_flight_item" do
    put :update, id: @ball_flight_item, ball_flight_item: { ball_flight_id: @ball_flight_item.ball_flight_id, shot_id: @ball_flight_item.shot_id }
    assert_redirected_to ball_flight_item_path(assigns(:ball_flight_item))
  end

  test "should destroy ball_flight_item" do
    assert_difference('BallFlightItem.count', -1) do
      delete :destroy, id: @ball_flight_item
    end

    assert_redirected_to ball_flight_items_path
  end
end
