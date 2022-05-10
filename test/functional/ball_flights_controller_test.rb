require 'test_helper'

class BallFlightsControllerTest < ActionController::TestCase
  setup do
    @ball_flight = ball_flights(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ball_flights)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ball_flight" do
    assert_difference('BallFlight.count') do
      post :create, ball_flight: { first_measurement_time: @ball_flight.first_measurement_time, last_measurement_time: @ball_flight.last_measurement_time, positions: @ball_flight.positions }
    end

    assert_redirected_to ball_flight_path(assigns(:ball_flight))
  end

  test "should show ball_flight" do
    get :show, id: @ball_flight
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ball_flight
    assert_response :success
  end

  test "should update ball_flight" do
    put :update, id: @ball_flight, ball_flight: { first_measurement_time: @ball_flight.first_measurement_time, last_measurement_time: @ball_flight.last_measurement_time, positions: @ball_flight.positions }
    assert_redirected_to ball_flight_path(assigns(:ball_flight))
  end

  test "should destroy ball_flight" do
    assert_difference('BallFlight.count', -1) do
      delete :destroy, id: @ball_flight
    end

    assert_redirected_to ball_flights_path
  end
end
