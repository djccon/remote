class ClubPathItemsController < ApplicationController
  # GET /club_path_items
  # GET /club_path_items.json
  def index
    @club_path_items = ClubPathItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @club_path_items }
    end
  end

  # GET /club_path_items/1
  # GET /club_path_items/1.json
  def show
    @club_path_item = ClubPathItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @club_path_item }
    end
  end

  # GET /club_path_items/new
  # GET /club_path_items/new.json
  def new
    @club_path_item = ClubPathItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @club_path_item }
    end
  end

  # GET /club_path_items/1/edit
  def edit
    @club_path_item = ClubPathItem.find(params[:id])
  end

  # POST /club_path_items
  # POST /club_path_items.json
  def create
    @club_path_item = ClubPathItem.new(params[:club_path_item])

    respond_to do |format|
      if @club_path_item.save
        format.html { redirect_to @club_path_item, notice: 'Club path item was successfully created.' }
        format.json { render json: @club_path_item, status: :created, location: @club_path_item }
      else
        format.html { render action: "new" }
        format.json { render json: @club_path_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /club_path_items/1
  # PUT /club_path_items/1.json
  def update
    @club_path_item = ClubPathItem.find(params[:id])

    respond_to do |format|
      if @club_path_item.update_attributes(params[:club_path_item])
        format.html { redirect_to @club_path_item, notice: 'Club path item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @club_path_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /club_path_items/1
  # DELETE /club_path_items/1.json
  def destroy
    @club_path_item = ClubPathItem.find(params[:id])
    @club_path_item.destroy

    respond_to do |format|
      format.html { redirect_to club_path_items_url }
      format.json { head :no_content }
    end
  end
end
