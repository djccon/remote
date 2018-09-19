require 'test_helper'

class DebugOutputsControllerTest < ActionController::TestCase
  setup do
    @debug_output = debug_outputs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:debug_outputs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create debug_output" do
    assert_difference('DebugOutput.count') do
      post :create, debug_output: { detail: @debug_output.detail, title: @debug_output.title }
    end

    assert_redirected_to debug_output_path(assigns(:debug_output))
  end

  test "should show debug_output" do
    get :show, id: @debug_output
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @debug_output
    assert_response :success
  end

  test "should update debug_output" do
    put :update, id: @debug_output, debug_output: { detail: @debug_output.detail, title: @debug_output.title }
    assert_redirected_to debug_output_path(assigns(:debug_output))
  end

  test "should destroy debug_output" do
    assert_difference('DebugOutput.count', -1) do
      delete :destroy, id: @debug_output
    end

    assert_redirected_to debug_outputs_path
  end
end
