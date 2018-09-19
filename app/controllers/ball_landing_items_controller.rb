class BallLandingItemsController < ApplicationController
  # GET /ball_landing_items
  # GET /ball_landing_items.json
  def index
    @ball_landing_items = BallLandingItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ball_landing_items }
    end
  end

  # GET /ball_landing_items/1
  # GET /ball_landing_items/1.json
  def show
    @ball_landing_item = BallLandingItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ball_landing_item }
    end
  end

  # GET /ball_landing_items/new
  # GET /ball_landing_items/new.json
  def new
    @ball_landing_item = BallLandingItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ball_landing_item }
    end
  end

  # GET /ball_landing_items/1/edit
  def edit
    @ball_landing_item = BallLandingItem.find(params[:id])
  end

  # POST /ball_landing_items
  # POST /ball_landing_items.json
  def create
    @ball_landing_item = BallLandingItem.new(params[:ball_landing_item])

    respond_to do |format|
      if @ball_landing_item.save
        format.html { redirect_to @ball_landing_item, notice: 'Ball landing item was successfully created.' }
        format.json { render json: @ball_landing_item, status: :created, location: @ball_landing_item }
      else
        format.html { render action: "new" }
        format.json { render json: @ball_landing_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ball_landing_items/1
  # PUT /ball_landing_items/1.json
  def update
    @ball_landing_item = BallLandingItem.find(params[:id])

    respond_to do |format|
      if @ball_landing_item.update_attributes(params[:ball_landing_item])
        format.html { redirect_to @ball_landing_item, notice: 'Ball landing item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ball_landing_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ball_landing_items/1
  # DELETE /ball_landing_items/1.json
  def destroy
    @ball_landing_item = BallLandingItem.find(params[:id])
    @ball_landing_item.destroy

    respond_to do |format|
      format.html { redirect_to ball_landing_items_url }
      format.json { head :no_content }
    end
  end
end
