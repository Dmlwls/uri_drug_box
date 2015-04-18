require 'test_helper'

class ProwsControllerTest < ActionController::TestCase
  setup do
    @prow = prows(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prows)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prow" do
    assert_difference('Prow.count') do
      post :create, prow: { drug_name: @prow.drug_name, period: @prow.period, prescription_id: @prow.prescription_id }
    end

    assert_redirected_to prow_path(assigns(:prow))
  end

  test "should show prow" do
    get :show, id: @prow
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @prow
    assert_response :success
  end

  test "should update prow" do
    patch :update, id: @prow, prow: { drug_name: @prow.drug_name, period: @prow.period, prescription_id: @prow.prescription_id }
    assert_redirected_to prow_path(assigns(:prow))
  end

  test "should destroy prow" do
    assert_difference('Prow.count', -1) do
      delete :destroy, id: @prow
    end

    assert_redirected_to prows_path
  end
end
