require 'test_helper'

class TyreFeesControllerTest < ActionController::TestCase
  setup do
    @tyre_fee = tyre_fees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tyre_fees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tyre_fee" do
    assert_difference('TyreFee.count') do
      post :create, tyre_fee: {  }
    end

    assert_redirected_to tyre_fee_path(assigns(:tyre_fee))
  end

  test "should show tyre_fee" do
    get :show, id: @tyre_fee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tyre_fee
    assert_response :success
  end

  test "should update tyre_fee" do
    patch :update, id: @tyre_fee, tyre_fee: {  }
    assert_redirected_to tyre_fee_path(assigns(:tyre_fee))
  end

  test "should destroy tyre_fee" do
    assert_difference('TyreFee.count', -1) do
      delete :destroy, id: @tyre_fee
    end

    assert_redirected_to tyre_fees_path
  end
end
