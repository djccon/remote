class LaunchItemsController < ApplicationController
  # GET /launch_items
  # GET /launch_items.json
  def index
    @launch_items = LaunchItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @launch_items }
    end
  end

  # GET /launch_items/1
  # GET /launch_items/1.json
  def show
    @launch_item = LaunchItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @launch_item }
    end
  end

  # GET /launch_items/new
  # GET /launch_items/new.json
  def new
    @launch_item = LaunchItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @launch_item }
    end
  end

  # GET /launch_items/1/edit
  def edit
    @launch_item = LaunchItem.find(params[:id])
  end

  # POST /launch_items
  # POST /launch_items.json
  def create
    @launch_item = LaunchItem.new(params[:launch_item])

    respond_to do |format|
      if @launch_item.save
        format.html { redirect_to @launch_item, notice: 'Launch item was successfully created.' }
        format.json { render json: @launch_item, status: :created, location: @launch_item }
      else
        format.html { render action: "new" }
        format.json { render json: @launch_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /launch_items/1
  # PUT /launch_items/1.json
  def update
    @launch_item = LaunchItem.find(params[:id])

    respond_to do |format|
      if @launch_item.update_attributes(params[:launch_item])
        format.html { redirect_to @launch_item, notice: 'Launch item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @launch_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /launch_items/1
  # DELETE /launch_items/1.json
  def destroy
    @launch_item = LaunchItem.find(params[:id])
    @launch_item.destroy

    respond_to do |format|
      format.html { redirect_to launch_items_url }
      format.json { head :no_content }
    end
  end
end
