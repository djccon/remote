class CommandItemsController < ApplicationController
  # GET /command_items
  # GET /command_items.json
  def index
    @command_items = CommandItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @command_items }
    end
  end

  # GET /command_items/1
  # GET /command_items/1.json
  def show
    @command_item = CommandItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @command_item }
    end
  end

  # GET /command_items/new
  # GET /command_items/new.json
  def new
    @command_item = CommandItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @command_item }
    end
  end

  # GET /command_items/1/edit
  def edit
    @command_item = CommandItem.find(params[:id])
  end

  # POST /command_items
  # POST /command_items.json
  def create
    @command_item = CommandItem.new(params[:command_item])

    respond_to do |format|
      if @command_item.save
        format.html { redirect_to @command_item, notice: 'Command item was successfully created.' }
        format.json { render json: @command_item, status: :created, location: @command_item }
      else
        format.html { render action: "new" }
        format.json { render json: @command_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /command_items/1
  # PUT /command_items/1.json
  def update
    @command_item = CommandItem.find(params[:id])

    respond_to do |format|
      if @command_item.update_attributes(params[:command_item])
        format.html { redirect_to @command_item, notice: 'Command item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @command_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /command_items/1
  # DELETE /command_items/1.json
  def destroy
    @command_item = CommandItem.find(params[:id])
    @command_item.destroy

    respond_to do |format|
      format.html { redirect_to command_items_url }
      format.json { head :no_content }
    end
  end
end
