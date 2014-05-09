require 'test_helper'

class TransportCardTypesControllerTest < ActionController::TestCase
  setup do
    @transport_card_type = transport_card_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transport_card_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transport_card_type" do
    assert_difference('TransportCardType.count') do
      post :create, transport_card_type: { name: @transport_card_type.name }
    end

    assert_redirected_to transport_card_type_path(assigns(:transport_card_type))
  end

  test "should show transport_card_type" do
    get :show, id: @transport_card_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @transport_card_type
    assert_response :success
  end

  test "should update transport_card_type" do
    patch :update, id: @transport_card_type, transport_card_type: { name: @transport_card_type.name }
    assert_redirected_to transport_card_type_path(assigns(:transport_card_type))
  end

  test "should destroy transport_card_type" do
    assert_difference('TransportCardType.count', -1) do
      delete :destroy, id: @transport_card_type
    end

    assert_redirected_to transport_card_types_path
  end
end
