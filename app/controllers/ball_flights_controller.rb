class BallFlightsController < ApplicationController
  # GET /ball_flights
  # GET /ball_flights.json
  def index
    @ball_flights = BallFlight.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ball_flights }
    end
  end

  # GET /ball_flights/1
  # GET /ball_flights/1.json
  def show
    @ball_flight = BallFlight.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ball_flight }
    end
  end

  # GET /ball_flights/new
  # GET /ball_flights/new.json
  def new
    @ball_flight = BallFlight.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ball_flight }
    end
  end

  # GET /ball_flights/1/edit
  def edit
    @ball_flight = BallFlight.find(params[:id])
  end

  # POST /ball_flights
  # POST /ball_flights.json
  def create
    @ball_flight = BallFlight.new(params[:ball_flight])

    respond_to do |format|
      if @ball_flight.save
        format.html { redirect_to @ball_flight, notice: 'Ball flight was successfully created.' }
        format.json { render json: @ball_flight, status: :created, location: @ball_flight }
      else
        format.html { render action: "new" }
        format.json { render json: @ball_flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ball_flights/1
  # PUT /ball_flights/1.json
  def update
    @ball_flight = BallFlight.find(params[:id])

    respond_to do |format|
      if @ball_flight.update_attributes(params[:ball_flight])
        format.html { redirect_to @ball_flight, notice: 'Ball flight was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ball_flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ball_flights/1
  # DELETE /ball_flights/1.json
  def destroy
    @ball_flight = BallFlight.find(params[:id])
    @ball_flight.destroy

    respond_to do |format|
      format.html { redirect_to ball_flights_url }
      format.json { head :no_content }
    end
  end
end
