class ClubPathsController < ApplicationController
  # GET /club_paths
  # GET /club_paths.json
  def index
    @club_paths = ClubPath.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @club_paths }
    end
  end

  # GET /club_paths/1
  # GET /club_paths/1.json
  def show
    @club_path = ClubPath.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @club_path }
    end
  end

  # GET /club_paths/new
  # GET /club_paths/new.json
  def new
    @club_path = ClubPath.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @club_path }
    end
  end

  # GET /club_paths/1/edit
  def edit
    @club_path = ClubPath.find(params[:id])
  end

  # POST /club_paths
  # POST /club_paths.json
  def create
    @club_path = ClubPath.new(params[:club_path])

    respond_to do |format|
      if @club_path.save
        format.html { redirect_to @club_path, notice: 'Club path was successfully created.' }
        format.json { render json: @club_path, status: :created, location: @club_path }
      else
        format.html { render action: "new" }
        format.json { render json: @club_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /club_paths/1
  # PUT /club_paths/1.json
  def update
    @club_path = ClubPath.find(params[:id])

    respond_to do |format|
      if @club_path.update_attributes(params[:club_path])
        format.html { redirect_to @club_path, notice: 'Club path was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @club_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /club_paths/1
  # DELETE /club_paths/1.json
  def destroy
    @club_path = ClubPath.find(params[:id])
    @club_path.destroy

    respond_to do |format|
      format.html { redirect_to club_paths_url }
      format.json { head :no_content }
    end
  end
end
