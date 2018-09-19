class CommandBlocksController < ApplicationController
  # GET /command_blocks
  # GET /command_blocks.json
  def index
    @command_blocks = CommandBlock.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @command_blocks }
    end
  end

  # GET /command_blocks/1
  # GET /command_blocks/1.json
  def show
    @command_block = CommandBlock.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @command_block }
    end
  end

  # GET /command_blocks/new
  # GET /command_blocks/new.json
  def new
    @command_block = CommandBlock.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @command_block }
    end
  end

  # GET /command_blocks/1/edit
  def edit
    @command_block = CommandBlock.find(params[:id])
  end

  # POST /command_blocks
  # POST /command_blocks.json
  def create
    @command_block = CommandBlock.new(params[:command_block])

    respond_to do |format|
      if @command_block.save
        format.html { redirect_to @command_block, notice: 'Command block was successfully created.' }
        format.json { render json: @command_block, status: :created, location: @command_block }
      else
        format.html { render action: "new" }
        format.json { render json: @command_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /command_blocks/1
  # PUT /command_blocks/1.json
  def update
    @command_block = CommandBlock.find(params[:id])

    respond_to do |format|
      if @command_block.update_attributes(params[:command_block])
        format.html { redirect_to @command_block, notice: 'Command block was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @command_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /command_blocks/1
  # DELETE /command_blocks/1.json
  def destroy
    @command_block = CommandBlock.find(params[:id])
    @command_block.destroy

    respond_to do |format|
      format.html { redirect_to command_blocks_url }
      format.json { head :no_content }
    end
  end
end
