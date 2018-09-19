class LiveXyzsController < ApplicationController
  # GET /live_xyzs
  # GET /live_xyzs.json
  def index
    @live_xyzs = LiveXyz.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @live_xyzs }
    end
  end

  # GET /live_xyzs/1
  # GET /live_xyzs/1.json
  def show
    @live_xyz = LiveXyz.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @live_xyz }
    end
  end

  # GET /live_xyzs/new
  # GET /live_xyzs/new.json
  def new
    @live_xyz = LiveXyz.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @live_xyz }
    end
  end

  # GET /live_xyzs/1/edit
  def edit
    @live_xyz = LiveXyz.find(params[:id])
  end

  # POST /live_xyzs
  # POST /live_xyzs.json
  def create
    @live_xyz = LiveXyz.new(params[:live_xyz])

    respond_to do |format|
      if @live_xyz.save
        format.html { redirect_to @live_xyz, notice: 'Live xyz was successfully created.' }
        format.json { render json: @live_xyz, status: :created, location: @live_xyz }
      else
        format.html { render action: "new" }
        format.json { render json: @live_xyz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /live_xyzs/1
  # PUT /live_xyzs/1.json
  def update
    @live_xyz = LiveXyz.find(params[:id])

    respond_to do |format|
      if @live_xyz.update_attributes(params[:live_xyz])
        format.html { redirect_to @live_xyz, notice: 'Live xyz was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @live_xyz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /live_xyzs/1
  # DELETE /live_xyzs/1.json
  def destroy
    @live_xyz = LiveXyz.find(params[:id])
    @live_xyz.destroy

    respond_to do |format|
      format.html { redirect_to live_xyzs_url }
      format.json { head :no_content }
    end
  end
end
