require 'test_helper'

class SetGroupsControllerTest < ActionController::TestCase
  setup do
    @set_group = set_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:set_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create set_group" do
    assert_difference('SetGroup.count') do
      post :create, set_group: { name: @set_group.name, subject_id: @set_group.subject_id, year: @set_group.year }
    end

    assert_redirected_to set_group_path(assigns(:set_group))
  end

  test "should show set_group" do
    get :show, id: @set_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @set_group
    assert_response :success
  end

  test "should update set_group" do
    patch :update, id: @set_group, set_group: { name: @set_group.name, subject_id: @set_group.subject_id, year: @set_group.year }
    assert_redirected_to set_group_path(assigns(:set_group))
  end

  test "should destroy set_group" do
    assert_difference('SetGroup.count', -1) do
      delete :destroy, id: @set_group
    end

    assert_redirected_to set_groups_path
  end
end
