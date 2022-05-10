require 'test_helper'

class ResultItemsControllerTest < ActionController::TestCase
  setup do
    @result_item = result_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:result_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create result_item" do
    assert_difference('ResultItem.count') do
      post :create, result_item: { distance_from_hole: @result_item.distance_from_hole, shot_id: @result_item.shot_id, user_id: @result_item.user_id }
    end

    assert_redirected_to result_item_path(assigns(:result_item))
  end

  test "should show result_item" do
    get :show, id: @result_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @result_item
    assert_response :success
  end

  test "should update result_item" do
    put :update, id: @result_item, result_item: { distance_from_hole: @result_item.distance_from_hole, shot_id: @result_item.shot_id, user_id: @result_item.user_id }
    assert_redirected_to result_item_path(assigns(:result_item))
  end

  test "should destroy result_item" do
    assert_difference('ResultItem.count', -1) do
      delete :destroy, id: @result_item
    end

    assert_redirected_to result_items_path
  end
end
