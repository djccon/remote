require 'test_helper'

class CommandItemsControllerTest < ActionController::TestCase
  setup do
    @command_item = command_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:command_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create command_item" do
    assert_difference('CommandItem.count') do
      post :create, command_item: { command_id: @command_item.command_id, shot_id: @command_item.shot_id }
    end

    assert_redirected_to command_item_path(assigns(:command_item))
  end

  test "should show command_item" do
    get :show, id: @command_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @command_item
    assert_response :success
  end

  test "should update command_item" do
    put :update, id: @command_item, command_item: { command_id: @command_item.command_id, shot_id: @command_item.shot_id }
    assert_redirected_to command_item_path(assigns(:command_item))
  end

  test "should destroy command_item" do
    assert_difference('CommandItem.count', -1) do
      delete :destroy, id: @command_item
    end

    assert_redirected_to command_items_path
  end
end
