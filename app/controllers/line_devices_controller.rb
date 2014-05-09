class LineDevicesController < ApplicationController
  before_action :set_line_device, only: [:show, :edit, :update, :destroy]

  # GET /line_devices
  # GET /line_devices.json
  def index
    @line_devices = LineDevice.all
  end

  # GET /line_devices/1
  # GET /line_devices/1.json
  def show
  end

  # GET /line_devices/new
  def new
    @line_device = LineDevice.new
  end

  # GET /line_devices/1/edit
  def edit
  end

  # POST /line_devices
  # POST /line_devices.json
  def create
    @line_device = LineDevice.new(line_device_params)

    respond_to do |format|
      if @line_device.save
        format.html { redirect_to @line_device, notice: 'Line device was successfully created.' }
        format.json { render action: 'show', status: :created, location: @line_device }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_devices/1
  # PATCH/PUT /line_devices/1.json
  def update
    respond_to do |format|
      if @line_device.update(line_device_params)
        format.html { redirect_to @line_device, notice: 'Line device was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @line_device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_devices/1
  # DELETE /line_devices/1.json
  def destroy
    @line_device.destroy
    respond_to do |format|
      format.html { redirect_to line_devices_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_device
      @line_device = LineDevice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_device_params
      params.require(:line_device).permit(:line_id, :vehicle_device_id)
    end
end
