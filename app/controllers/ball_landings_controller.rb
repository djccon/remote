class BallLandingsController < ApplicationController
  # GET /ball_landings
  # GET /ball_landings.json
  def index
    @ball_landings = BallLanding.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ball_landings }
    end
  end

  # GET /ball_landings/1
  # GET /ball_landings/1.json
  def show
    @ball_landing = BallLanding.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ball_landing }
    end
  end

  # GET /ball_landings/new
  # GET /ball_landings/new.json
  def new
    @ball_landing = BallLanding.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ball_landing }
    end
  end

  # GET /ball_landings/1/edit
  def edit
    @ball_landing = BallLanding.find(params[:id])
  end

  # POST /ball_landings
  # POST /ball_landings.json
  def create
    response = Hash.new
    jsonPayload = params[:ball_landing]
    ball_landing_hash = JSON.parse(jsonPayload)
    @ball_landing = BallLanding.new(ball_landing_hash)
    response[:ball_landing] = @ball_landing
    response[:status] = 'ok'
    render json: response 
    return 

    # jsonPayload = params[:ball_landing]
    # ball_landing_hash = JSON.parse(jsonPayload)
    # #@ball_landing = BallLanding.new(ball_landing_hash)
    # format.json { render json: @ball_landing, status: :created, location: ball_landing_hash }
    # return

    # respond_to do |format|
    #   if @ball_landing.save
    #     format.html { redirect_to @ball_landing, notice: 'Ball landing was successfully created.' }
    #     format.json { render json: @ball_landing, status: :created, location: @ball_landing }
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @ball_landing.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PUT /ball_landings/1
  # PUT /ball_landings/1.json
  def update
    @ball_landing = BallLanding.find(params[:id])

    respond_to do |format|
      if @ball_landing.update_attributes(params[:ball_landing])
        format.html { redirect_to @ball_landing, notice: 'Ball landing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ball_landing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ball_landings/1
  # DELETE /ball_landings/1.json
  def destroy
    @ball_landing = BallLanding.find(params[:id])
    @ball_landing.destroy

    respond_to do |format|
      format.html { redirect_to ball_landings_url }
      format.json { head :no_content }
    end
  end
end
