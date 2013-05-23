class LaunchesController < ApplicationController
  # GET /launches
  # GET /launches.json
  def index
    @launches = Launch.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @launches }
    end
  end

  # GET /launches/1
  # GET /launches/1.json
  def show
    @launch = Launch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @launch }
    end
  end

  # GET /launches/new
  # GET /launches/new.json
  def new
    @launch = Launch.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @launch }
    end
  end

  # GET /launches/1/edit
  def edit
    @launch = Launch.find(params[:id])
  end

  # POST /launches
  # POST /launches.json
  def create
    @launch = Launch.new(params[:launch])

    respond_to do |format|
      if @launch.save
        format.html { redirect_to @launch, notice: 'Launch was successfully created.' }
        format.json { render json: @launch, status: :created, location: @launch }
      else
        format.html { render action: "new" }
        format.json { render json: @launch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /launches/1
  # PUT /launches/1.json
  def update
    @launch = Launch.find(params[:id])

    respond_to do |format|
      if @launch.update_attributes(params[:launch])
        format.html { redirect_to @launch, notice: 'Launch was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @launch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /launches/1
  # DELETE /launches/1.json
  def destroy
    @launch = Launch.find(params[:id])
    @launch.destroy

    respond_to do |format|
      format.html { redirect_to launches_url }
      format.json { head :no_content }
    end
  end
end
