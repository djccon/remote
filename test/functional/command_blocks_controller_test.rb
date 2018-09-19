require 'test_helper'

class CommandBlocksControllerTest < ActionController::TestCase
  setup do
    @command_block = command_blocks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:command_blocks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create command_block" do
    assert_difference('CommandBlock.count') do
      post :create, command_block: { commands: @command_block.commands }
    end

    assert_redirected_to command_block_path(assigns(:command_block))
  end

  test "should show command_block" do
    get :show, id: @command_block
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @command_block
    assert_response :success
  end

  test "should update command_block" do
    put :update, id: @command_block, command_block: { commands: @command_block.commands }
    assert_redirected_to command_block_path(assigns(:command_block))
  end

  test "should destroy command_block" do
    assert_difference('CommandBlock.count', -1) do
      delete :destroy, id: @command_block
    end

    assert_redirected_to command_blocks_path
  end
end
