class ShotsController < ApplicationController
  # GET /shots
  # GET /shots.json
  def index
    @shots = Shot.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shots }
    end
  end

  # GET /shots/1
  # GET /shots/1.json
  def show
    results = Hash.new

    # Get the shot object

    @shot = Shot.find(params[:id])
    launch_items = @shot.launch_items

    # Collect all launch items

    launches = Array.new
    launch_items.each do |item|
      launch = Launch.find(item.launch_id)
      launches << launch
    end 

    # Collect all ball_landing items

    ball_landing_items = @shot.ball_landing_items
    results[:num_ball_landing_items] = ball_landing_items.length

    ball_landings = Array.new
    ball_landing_items.each do |item|
      ball_landing = BallLanding.find(item.ball_landing_id)
      ball_landings << ball_landing
    end 

    # Collect all ball_flight items

    ball_flight_items = @shot.ball_flight_items
    results[:num_ball_flight_items] = ball_flight_items.length

    ball_flights = Array.new
    ball_flight_items.each do |item|
      ball_flight = BallFlight.find(item.ball_flight_id)
      ball_flights << ball_flight
    end 

    # Collect all club_path items

    club_path_items = @shot.club_path_items
    results[:num_club_path_items] = club_path_items.length

    club_paths = Array.new
    club_path_items.each do |item|
      club_path = ClubPath.find(item.club_path_id)
      club_paths << club_path
    end 

    # Collect all the command items

    command_items = @shot.command_items

    logger.debug ">>>>>>>> " + "number of command items: "  + command_items.length.to_s

    results[:num_command_items] = command_items.length

    commands = Array.new
    command_items.each do |item|
      command = Command.find(item.command_id)
      commands << command
    end 

    # Collect all the weather items

    weather_items = @shot.weather_items

    results[:num_weather_items] = weather_items.length

    weathers = Array.new
    weather_items.each do |item|
      weather = Weather.find(item.weather_id)
      weathers << weather
    end 

    # Package up the results

    results[:shot] = @shot
    results[:launch_items] = launch_items
    results[:launches] = launches
    results[:ball_landing_items] = ball_landing_items
    results[:ball_landings] = ball_landings
    results[:ball_flights] = ball_flights
    results[:club_paths] = club_paths
    results[:commands] = commands
    results[:weathers] = weathers

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: results }
    end
  end

  # GET /shots/new
  # GET /shots/new.json
  def new
    @shot = Shot.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shot }
    end
  end

  # GET /shots/1/edit
  def edit
    @shot = Shot.find(params[:id])
  end

  # POST /shots
  # POST /shots.json
  def create
    @shot = Shot.new(params[:shot])

    respond_to do |format|
      if @shot.save
        format.html { redirect_to @shot, notice: 'Shot was successfully created.' }
        format.json { render json: @shot, status: :created, location: @shot }
      else
        format.html { render action: "new" }
        format.json { render json: @shot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shots/1
  # PUT /shots/1.json
  def update
    @shot = Shot.find(params[:id])

    respond_to do |format|
      if @shot.update_attributes(params[:shot])
        format.html { redirect_to @shot, notice: 'Shot was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @shot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shots/1
  # DELETE /shots/1.json
  def destroy
    @shot = Shot.find(params[:id])
    @shot.destroy

    respond_to do |format|
      format.html { redirect_to shots_url }
      format.json { head :no_content }
    end
  end
end
