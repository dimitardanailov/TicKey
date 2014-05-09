require 'test_helper'

class LineDevicesControllerTest < ActionController::TestCase
  setup do
    @line_device = line_devices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_devices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_device" do
    assert_difference('LineDevice.count') do
      post :create, line_device: { line_id: @line_device.line_id, vehicle_device_id: @line_device.vehicle_device_id }
    end

    assert_redirected_to line_device_path(assigns(:line_device))
  end

  test "should show line_device" do
    get :show, id: @line_device
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @line_device
    assert_response :success
  end

  test "should update line_device" do
    patch :update, id: @line_device, line_device: { line_id: @line_device.line_id, vehicle_device_id: @line_device.vehicle_device_id }
    assert_redirected_to line_device_path(assigns(:line_device))
  end

  test "should destroy line_device" do
    assert_difference('LineDevice.count', -1) do
      delete :destroy, id: @line_device
    end

    assert_redirected_to line_devices_path
  end
end
