require 'test_helper'

class VehicleDevicesControllerTest < ActionController::TestCase
  setup do
    @vehicle_device = vehicle_devices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vehicle_devices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vehicle_device" do
    assert_difference('VehicleDevice.count') do
      post :create, vehicle_device: { major: @vehicle_device.major, minor: @vehicle_device.minor, unique_id: @vehicle_device.unique_id }
    end

    assert_redirected_to vehicle_device_path(assigns(:vehicle_device))
  end

  test "should show vehicle_device" do
    get :show, id: @vehicle_device
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vehicle_device
    assert_response :success
  end

  test "should update vehicle_device" do
    patch :update, id: @vehicle_device, vehicle_device: { major: @vehicle_device.major, minor: @vehicle_device.minor, unique_id: @vehicle_device.unique_id }
    assert_redirected_to vehicle_device_path(assigns(:vehicle_device))
  end

  test "should destroy vehicle_device" do
    assert_difference('VehicleDevice.count', -1) do
      delete :destroy, id: @vehicle_device
    end

    assert_redirected_to vehicle_devices_path
  end
end
