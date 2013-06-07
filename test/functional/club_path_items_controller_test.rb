require 'test_helper'

class ClubPathItemsControllerTest < ActionController::TestCase
  setup do
    @club_path_item = club_path_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:club_path_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create club_path_item" do
    assert_difference('ClubPathItem.count') do
      post :create, club_path_item: { club_path_id: @club_path_item.club_path_id, shot_id: @club_path_item.shot_id }
    end

    assert_redirected_to club_path_item_path(assigns(:club_path_item))
  end

  test "should show club_path_item" do
    get :show, id: @club_path_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @club_path_item
    assert_response :success
  end

  test "should update club_path_item" do
    put :update, id: @club_path_item, club_path_item: { club_path_id: @club_path_item.club_path_id, shot_id: @club_path_item.shot_id }
    assert_redirected_to club_path_item_path(assigns(:club_path_item))
  end

  test "should destroy club_path_item" do
    assert_difference('ClubPathItem.count', -1) do
      delete :destroy, id: @club_path_item
    end

    assert_redirected_to club_path_items_path
  end
end
