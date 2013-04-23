class ApiController < ApplicationController

  def send_command
    response = Hash.new

    command = Command.new do |c|
      c.cmd = params[:cmd]
    end
    command.save

    response[:status] = 'ok'
    response[:data] = command

    render json: response 
  end

  def get_commands
    # Get oldest command from unprocessed commands
    response = Hash.new
    response[:status] = "ok"
    response[:type] = "commands"

    latestCommand = Command.last

    commands = Array.new
    
    command = Hash.new

    commands << latestCommand
    
    # command[:robot_id] = '1'
    # command[:msg] = 'MS108'

    # commands << command

    # command = Hash.new
    # command[:robot_id] = '1'
    # command[:msg] = 'MS109'

    # commands << command

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
        r.response = 'res111'
    end
    # save response
    new_response.save

    # mark command as processed
    command.cmd += '!'
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

end
