class WeatherItemsController < ApplicationController
  # GET /weather_items
  # GET /weather_items.json
  def index
    @weather_items = WeatherItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @weather_items }
    end
  end

  # GET /weather_items/1
  # GET /weather_items/1.json
  def show
    @weather_item = WeatherItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @weather_item }
    end
  end

  # GET /weather_items/new
  # GET /weather_items/new.json
  def new
    @weather_item = WeatherItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @weather_item }
    end
  end

  # GET /weather_items/1/edit
  def edit
    @weather_item = WeatherItem.find(params[:id])
  end

  # POST /weather_items
  # POST /weather_items.json
  def create
    @weather_item = WeatherItem.new(params[:weather_item])

    respond_to do |format|
      if @weather_item.save
        format.html { redirect_to @weather_item, notice: 'Weather item was successfully created.' }
        format.json { render json: @weather_item, status: :created, location: @weather_item }
      else
        format.html { render action: "new" }
        format.json { render json: @weather_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /weather_items/1
  # PUT /weather_items/1.json
  def update
    @weather_item = WeatherItem.find(params[:id])

    respond_to do |format|
      if @weather_item.update_attributes(params[:weather_item])
        format.html { redirect_to @weather_item, notice: 'Weather item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @weather_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weather_items/1
  # DELETE /weather_items/1.json
  def destroy
    @weather_item = WeatherItem.find(params[:id])
    @weather_item.destroy

    respond_to do |format|
      format.html { redirect_to weather_items_url }
      format.json { head :no_content }
    end
  end
end
