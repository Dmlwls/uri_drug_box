require 'test_helper'

class BoxPartsControllerTest < ActionController::TestCase
  setup do
    @box_part = box_parts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:box_parts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create box_part" do
    assert_difference('BoxPart.count') do
      post :create, box_part: { part_num: @box_part.part_num, prow_id: @box_part.prow_id }
    end

    assert_redirected_to box_part_path(assigns(:box_part))
  end

  test "should show box_part" do
    get :show, id: @box_part
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @box_part
    assert_response :success
  end

  test "should update box_part" do
    patch :update, id: @box_part, box_part: { part_num: @box_part.part_num, prow_id: @box_part.prow_id }
    assert_redirected_to box_part_path(assigns(:box_part))
  end

  test "should destroy box_part" do
    assert_difference('BoxPart.count', -1) do
      delete :destroy, id: @box_part
    end

    assert_redirected_to box_parts_path
  end
end
