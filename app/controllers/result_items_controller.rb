class ResultItemsController < ApplicationController
  # GET /result_items
  # GET /result_items.json
  def index
    @result_items = ResultItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @result_items }
    end
  end

  # GET /result_items/1
  # GET /result_items/1.json
  def show
    @result_item = ResultItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @result_item }
    end
  end

  # GET /result_items/new
  # GET /result_items/new.json
  def new
    @result_item = ResultItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @result_item }
    end
  end

  # GET /result_items/1/edit
  def edit
    @result_item = ResultItem.find(params[:id])
  end

  # POST /result_items
  # POST /result_items.json
  def create  
    @result_item = ResultItem.new(params[:result_item])

    respond_to do |format|
      if @result_item.save
        format.html { redirect_to @result_item, notice: 'Result item was successfully created.' }
        format.json { render json: @result_item, status: :created, location: @result_item }
      else
        format.html { render action: "new" }
        format.json { render json: @result_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /result_items/1
  # PUT /result_items/1.json
  def update
    @result_item = ResultItem.find(params[:id])

    respond_to do |format|
      if @result_item.update_attributes(params[:result_item])
        format.html { redirect_to @result_item, notice: 'Result item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @result_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /result_items/1
  # DELETE /result_items/1.json
  def destroy
    @result_item = ResultItem.find(params[:id])
    @result_item.destroy

    respond_to do |format|
      format.html { redirect_to result_items_url }
      format.json { head :no_content }
    end
  end
end
