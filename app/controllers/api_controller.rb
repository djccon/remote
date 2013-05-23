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


  def create_shot
    response = Hash.new
    shot = Shot.new
    shot.save
    response[:shot] = shot
    render json: shot  
  end


end
