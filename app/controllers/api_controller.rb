class ApiController < ApplicationController

  def send_command
    response = Hash.new

    command = Command.new do |c|
      c.cmd = params[:cmd]
      c.processed = false
    end
    command.save

    response[:status] = 'ok'
    response[:data] = command

    render json: response 
  end

  def get_commands
    # Get newest command from unprocessed commands  

    response = Hash.new
    response[:status] = "ok"
    response[:type] = "commands"

    latestCommand = Command.last

    commands = Array.new

    if (!latestCommand.nil?)
        if (!latestCommand.processed)
            commands << latestCommand
        end
    end

    response[:data] = commands
    render json: response 
  end

  def get_latest_weather
    # Get newest command from unprocessed commands

    response = Hash.new

    response[:status] = "ok"
    response[:type] = "weather"

    latestWeather = Weather.last

    if (!params[:random].nil?)
        latestWeather.wind_speed = 15 + rand(7)
        latestWeather.wind_direction = 289 + rand(25)
    end

    if (!latestWeather.nil?)
        response[:data] = latestWeather
    end

    render json: response 
  end

  def get_all_commands
    response = Hash.new
    response[:status] = "ok"
    response[:type] = "commands"

    #latestCommand = Command.find_all()

    commands = Command.all

    response[:data] = commands
    render json: response 
  end

  def send_response
    # get command by command_id
    command = Command.find_by_id(params[:command_id])
    # create a new response object 
    new_response = Response.new do |r|
        # fill in command_id, response text
        r.command_id = command.id
        r.response = params[:response]
    end
    # save response
    new_response.save

    # mark command as processed
    command.processed = true
    # save command
    command.save
    # return reponse object

    response = Hash.new
    response[:status] = "ok"
    response[:data] = new_response
    render json: response 
  end

  def get_responses
    response = Hash.new
    response[:status] = "ok"
    response[:type] = "responses"

    responses = Array.new
    
    response = Hash.new
    response[:robot_id] = '1'
    response[:msg] = '>'

    responses << response

    response = Hash.new
    response[:robot_id] = '1'
    response[:msg] = '>'

    responses << response

    response[:data] = responses
    render json: response 
  end

  def get_all_responses
    response = Hash.new
    response[:status] = "ok"
    response[:type] = "responses"

    responses = Response.all

    response[:data] = responses
    render json: response 
  end

  def push_command_block
    response = Hash.new
    command_block_id = params[:cmd]
    
    if (!command_block_id.nil?)

        command_block = CommandBlock.find_by_id(command_block_id)
        if (!command_block.nil?)
            command = Command.new do |c|
              c.cmd = command_block.commands
              c.processed = false
            end
            command.save
        end
    end

    response[:status] = 'ok'
    response[:data] = command

    render json: response 
  end

  def send_swing_command    
    response = Hash.new

    power = params[:power]
    direction = params[:direction]

    # AL10050,AR52|AL305,AR62|TR52|TR62|MS105
    new_command = ""
    
    if (!power.nil? || !direction.nil?)
        
        new_command += "AL" + direction + ",AR52|" 
        new_command += "AL" + power + ",AR62|" 
        new_command += "TR52|TR62|MS105" 

        command = Command.new do |c|
          c.cmd = new_command
          c.processed = false
        end
        
        command.save

    end

    response[:status] = 'ok'
    response[:data] = command

    render json: response 
  end

  def mimic_params
    response = Hash.new

    response[:data] = params
    response[:status] = 'ok'

    render json: response 
  end


  def send_shot_launch_conditions    

    #try the bulk create using actual_params. Have to deal with the valid variable first though.

    response = Hash.new
    json_payload = params[:launch]
    actual_params = JSON.parse(json_payload)

    launch = Launch.new do |l|
        l.club_speed = actual_params["club_speed"].to_f
        l.ball_speed = actual_params["ball_speed"].to_f
        l.smash_factor = actual_params["smash_factor"].to_f
        l.ball_horizontal_angle = actual_params["ball_horizontal_angle"].to_f
        l.ball_vertical_angle = actual_params["ball_vertical_angle"].to_f
        l.dynamic_loft = actual_params["dynamic_loft"].to_f
        l.face_angle = actual_params["face_angle"].to_f
        l.spin_rate = actual_params["spin_rate"].to_f
        l.spin_axis_horizontal = actual_params["spin_axis_horizontal"].to_f
        l.spin_axis_vertical = actual_params["spin_axis_vertical"].to_f
        l.club_path = actual_params["club_path"].to_f
        l.attack_angle = actual_params["attack_angle"].to_f
        l.swing_plane_horizontal = actual_params["swing_plane_horizontal"].to_f
        l.swing_plane_vertical = actual_params["swing_plane_vertical"].to_f
    end
    launch.save

    shot_id = params[:shot_id]

    launch_item = LaunchItem.new do |li|
        li.shot_id = shot_id.to_i
        li.launch_id = launch.id
    end
    launch_item.save

    response[:launch] = launch
    response[:shot_id] = shot_id
    response[:launch_item] = launch_item
    # response[:params] = actual_params
    response[:status] = 'ok'

    render json: response 
  end


  def send_shot_ball_landing
    response = Hash.new

    json_payload = params[:payload]
    actual_params = JSON.parse(json_payload)

    #actual_params = params

    landing = BallLanding.new do |obj|
        obj.time = actual_params["time"].to_f
        obj.x = actual_params["x"].to_f
        obj.y = actual_params["y"].to_f
        obj.z = actual_params["z"].to_f
        obj.carry = actual_params["carry"].to_f
        obj.side = actual_params["side"].to_f
        obj.speed = actual_params["speed"].to_f
        obj.vertical_angle = actual_params["vertical_angle"].to_f
        obj.horizontal_angle = actual_params["horizontal_angle"].to_f
    end
    landing.save

    shot_id = params[:shot_id]

    ball_landing_item = BallLandingItem.new do |item|
        item.shot_id = shot_id.to_i
        item.ball_landing_id = landing.id
    end
    ball_landing_item.save

    response[:shot_id] = shot_id
    response[:ball_landing] = landing
    response[:ball_landing_item] = ball_landing_item
    
    response[:params] = actual_params
    response[:status] = 'ok'

    render json: response 
  end


  def send_shot_ball_flight
    response = Hash.new

    json_payload = params[:payload]
    actual_params = JSON.parse(json_payload)

    #actual_params = params

    flight = BallFlight.new do |obj|
        obj.first_measurement_time = actual_params["first_measurement_time"].to_f
        obj.last_measurement_time = actual_params["last_measurement_time"].to_f
        obj.positions = actual_params["positions"].to_json
    end
    flight.save

    shot_id = params[:shot_id]

    ball_flight_item = BallFlightItem.new do |item|
        item.shot_id = shot_id.to_i
        item.ball_flight_id = flight.id
    end
    ball_flight_item.save

    response[:shot_id] = shot_id
    response[:ball_flight] = flight
    response[:ball_flight_item] = ball_flight_item
    
    response[:params] = actual_params
    response[:status] = 'ok'

    render json: response 
  end


  def send_shot_club_path
    response = Hash.new

    json_payload = params[:payload]
    actual_params = JSON.parse(json_payload)

    club_path = ClubPath.new do |obj|
        obj.first_measurement_time = actual_params["first_measurement_time"].to_f
        obj.last_measurement_time = actual_params["last_measurement_time"].to_f
        obj.positions = actual_params["positions"].to_s
    end
    club_path.save

    shot_id = params[:shot_id]

    club_path_item = ClubPathItem.new do |item|
        item.shot_id = shot_id.to_i
        item.club_path_id = club_path.id
    end
    club_path_item.save

    response[:shot_id] = shot_id
    response[:club_path] = club_path
    response[:club_path_item] = club_path_item
    
    response[:params] = actual_params
    response[:status] = 'ok'

    render json: response 
  end


  def send_shot_weather
    response = Hash.new

    json_payload = params[:payload]
    actual_params = JSON.parse(json_payload)

    #actual_params = params

    weather = Weather.new do |obj|
        obj.wind_speed = actual_params["wind_speed"].to_f
        obj.wind_direction = actual_params["wind_direction"].to_f
        obj.weather_type = "shot"
    end
    weather.save

    shot_id = params[:shot_id]

    weather_item = WeatherItem.new do |item|
        item.shot_id = shot_id.to_i
        item.weather_id = weather.id
    end
    weather_item.save

    response[:shot_id] = shot_id
    response[:weather] = weather
    response[:weather_item] = weather_item
    
    response[:params] = actual_params
    response[:status] = 'ok'

    render json: response 
  end


  def send_weather
    response = Hash.new

    json_payload = params[:payload]
    actual_params = JSON.parse(json_payload)

    weather = Weather.new do |obj|
        obj.wind_speed = actual_params["wind_speed"].to_f
        obj.wind_direction = actual_params["wind_direction"].to_f
        obj.weather_type = "periodic"
    end
    weather.save

    response[:weather] = weather
    response[:params] = actual_params
    response[:status] = 'ok'

    render json: response 
  end


  def create_shot
    response = Hash.new

    json_payload = params[:payload]
    actual_params = params

    shot = Shot.new
    shot.save

    response[:shot] = shot

    command_id = actual_params[:command_id]
    
    logger.debug ">>>>>>> command_id " + command_id
    logger.debug ">>>>>>> shot_id " + shot.id.to_s

    begin
        command = Command.find(command_id)
    rescue => e
        response[:error] = "Exception: #{e}"
        render json: response
        return
    end

    if(!command.nil?)
        command_item = CommandItem.new do |item|
            item.shot_id = shot.id
            item.command_id = command_id
        end
        command_item.save
    end

    render json: shot
  end


  def get_command_item
    response = Hash.new
    commandItem = CommandItem.find_by_command_id(params[:command_id]);
    response[:data] = commandItem;
    render json: response
  end


  def output_debug_string
    response = Hash.new
    json_payload = params[:payload]
    #actual_params = JSON.parse(json_payload)
    actual_params = params

    outputDebugString = DebugOutput.new do |obj|
        obj.title = actual_params["title"]
        obj.detail = actual_params["detail"]
    end
    outputDebugString.save

    response[:status] = 'ok';
    render json: response  
  end

  def get_leaderboard
    response = Hash.new

    #top_results = ResultItem.order("distance_from_hole ASC").first(25)
    #top_results = ResultItem.joins(:users);
    top_results = ResultItem.find_by_sql("SELECT * FROM result_items INNER JOIN users ON users.id = result_items.user_id ORDER BY result_items.distance_from_hole asc")
    response[:data] = top_results;

    response[:status] = 'ok';
    render json: response  
  end


  def get_score_history
    response = Hash.new

    user_id = params[:user_id]

    top_results = ResultItem.where(user_id: user_id).order("distance_from_hole ASC").first(10)
    response[:data] = top_results;

    response[:status] = 'ok';
    render json: response  
  end

  def send_email
    response = Hash.new
    
    require 'mandrill'
    
    m = Mandrill::API.new # All official Mandrill API clients will automatically pull your API key from the environment
    rendered = m.templates.render 'MyTemplate', [{:name => 'main', :content => 'The main content block'}]
    puts rendered['html'] # print out the rendered HTML

    response[:status] = 'ok';
    render json: response  
  end

  def get_live_xyz
    response = Hash.new

    xyzRecord = LiveXyz.first
    if (xyzRecord.nil?)
        response[:status] = 'na';
        render json: response  
        return 0
    end
    
    xyz = Hash.new
    xyz[:x] = xyzRecord.x
    xyz[:y] = xyzRecord.y
    xyz[:z] = xyzRecord.z

    response[:data] = xyz

    response[:status] = 'ok';
    render json: response  
  end

  def set_live_xyz
    response = Hash.new

    json_payload = params[:payload]
    actual_params = JSON.parse(json_payload)

    xyzRecord = LiveXyz.first
    if xyzRecord.nil?
        xyzRecord = LiveXyz.new
    end

    xyzRecord.x = actual_params["x"].to_f
    xyzRecord.y = actual_params["y"].to_f
    xyzRecord.z = actual_params["z"].to_f

    xyzRecord.save!
    
    response[:status] = 'ok';
    render json: response  
  end

end
