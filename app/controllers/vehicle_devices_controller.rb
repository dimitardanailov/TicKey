class VehicleDevicesController < ApplicationController
  before_action :set_vehicle_device, only: [:show, :edit, :update, :destroy]

  # GET /vehicle_devices
  # GET /vehicle_devices.json
  def index
    @vehicle_devices = VehicleDevice.all
  end

  # GET /vehicle_devices/1
  # GET /vehicle_devices/1.json
  def show
  end

  # GET /vehicle_devices/new
  def new
    @vehicle_device = VehicleDevice.new
  end

  # GET /vehicle_devices/1/edit
  def edit
  end

  # POST /vehicle_devices
  # POST /vehicle_devices.json
  def create
    @vehicle_device = VehicleDevice.new(vehicle_device_params)

    respond_to do |format|
      if @vehicle_device.save
        format.html { redirect_to @vehicle_device, notice: 'Vehicle device was successfully created.' }
        format.json { render action: 'show', status: :created, location: @vehicle_device }
      else
        format.html { render action: 'new' }
        format.json { render json: @vehicle_device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicle_devices/1
  # PATCH/PUT /vehicle_devices/1.json
  def update
    respond_to do |format|
      if @vehicle_device.update(vehicle_device_params)
        format.html { redirect_to @vehicle_device, notice: 'Vehicle device was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @vehicle_device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicle_devices/1
  # DELETE /vehicle_devices/1.json
  def destroy
    @vehicle_device.destroy
    respond_to do |format|
      format.html { redirect_to vehicle_devices_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle_device
      @vehicle_device = VehicleDevice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vehicle_device_params
      params.require(:vehicle_device).permit(:unique_id, :major, :minor)
    end
end
