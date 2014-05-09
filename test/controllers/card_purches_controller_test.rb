require 'test_helper'

class CardPurchesControllerTest < ActionController::TestCase
  setup do
    @card_purch = card_purches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:card_purches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create card_purch" do
    assert_difference('CardPurch.count') do
      post :create, card_purch: { expire_date: @card_purch.expire_date, line_id: @card_purch.line_id, transport_card_type_id: @card_purch.transport_card_type_id, user_id: @card_purch.user_id }
    end

    assert_redirected_to card_purch_path(assigns(:card_purch))
  end

  test "should show card_purch" do
    get :show, id: @card_purch
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @card_purch
    assert_response :success
  end

  test "should update card_purch" do
    patch :update, id: @card_purch, card_purch: { expire_date: @card_purch.expire_date, line_id: @card_purch.line_id, transport_card_type_id: @card_purch.transport_card_type_id, user_id: @card_purch.user_id }
    assert_redirected_to card_purch_path(assigns(:card_purch))
  end

  test "should destroy card_purch" do
    assert_difference('CardPurch.count', -1) do
      delete :destroy, id: @card_purch
    end

    assert_redirected_to card_purches_path
  end
end
