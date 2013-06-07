class BallFlightItemsController < ApplicationController
  # GET /ball_flight_items
  # GET /ball_flight_items.json
  def index
    @ball_flight_items = BallFlightItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ball_flight_items }
    end
  end

  # GET /ball_flight_items/1
  # GET /ball_flight_items/1.json
  def show
    @ball_flight_item = BallFlightItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ball_flight_item }
    end
  end

  # GET /ball_flight_items/new
  # GET /ball_flight_items/new.json
  def new
    @ball_flight_item = BallFlightItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ball_flight_item }
    end
  end

  # GET /ball_flight_items/1/edit
  def edit
    @ball_flight_item = BallFlightItem.find(params[:id])
  end

  # POST /ball_flight_items
  # POST /ball_flight_items.json
  def create
    @ball_flight_item = BallFlightItem.new(params[:ball_flight_item])

    respond_to do |format|
      if @ball_flight_item.save
        format.html { redirect_to @ball_flight_item, notice: 'Ball flight item was successfully created.' }
        format.json { render json: @ball_flight_item, status: :created, location: @ball_flight_item }
      else
        format.html { render action: "new" }
        format.json { render json: @ball_flight_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ball_flight_items/1
  # PUT /ball_flight_items/1.json
  def update
    @ball_flight_item = BallFlightItem.find(params[:id])

    respond_to do |format|
      if @ball_flight_item.update_attributes(params[:ball_flight_item])
        format.html { redirect_to @ball_flight_item, notice: 'Ball flight item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ball_flight_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ball_flight_items/1
  # DELETE /ball_flight_items/1.json
  def destroy
    @ball_flight_item = BallFlightItem.find(params[:id])
    @ball_flight_item.destroy

    respond_to do |format|
      format.html { redirect_to ball_flight_items_url }
      format.json { head :no_content }
    end
  end
end
