class DebugOutputsController < ApplicationController
  # GET /debug_outputs
  # GET /debug_outputs.json
  def index
    @debug_outputs = DebugOutput.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @debug_outputs }
    end
  end

  # GET /debug_outputs/1
  # GET /debug_outputs/1.json
  def show
    @debug_output = DebugOutput.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @debug_output }
    end
  end

  # GET /debug_outputs/new
  # GET /debug_outputs/new.json
  def new
    @debug_output = DebugOutput.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @debug_output }
    end
  end

  # GET /debug_outputs/1/edit
  def edit
    @debug_output = DebugOutput.find(params[:id])
  end

  # POST /debug_outputs
  # POST /debug_outputs.json
  def create
    @debug_output = DebugOutput.new(params[:debug_output])

    respond_to do |format|
      if @debug_output.save
        format.html { redirect_to @debug_output, notice: 'Debug output was successfully created.' }
        format.json { render json: @debug_output, status: :created, location: @debug_output }
      else
        format.html { render action: "new" }
        format.json { render json: @debug_output.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /debug_outputs/1
  # PUT /debug_outputs/1.json
  def update
    @debug_output = DebugOutput.find(params[:id])

    respond_to do |format|
      if @debug_output.update_attributes(params[:debug_output])
        format.html { redirect_to @debug_output, notice: 'Debug output was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @debug_output.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /debug_outputs/1
  # DELETE /debug_outputs/1.json
  def destroy
    @debug_output = DebugOutput.find(params[:id])
    @debug_output.destroy

    respond_to do |format|
      format.html { redirect_to debug_outputs_url }
      format.json { head :no_content }
    end
  end
end
