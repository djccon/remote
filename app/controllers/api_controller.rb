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

end
