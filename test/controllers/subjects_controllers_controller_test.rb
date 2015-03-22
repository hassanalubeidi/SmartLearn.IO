require 'test_helper'

class SubjectsControllersControllerTest < ActionController::TestCase
  setup do
    @subjects_controller = subjects_controllers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subjects_controllers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subjects_controller" do
    assert_difference('SubjectsController.count') do
      post :create, subjects_controller: {  }
    end

    assert_redirected_to subjects_controller_path(assigns(:subjects_controller))
  end

  test "should show subjects_controller" do
    get :show, id: @subjects_controller
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subjects_controller
    assert_response :success
  end

  test "should update subjects_controller" do
    patch :update, id: @subjects_controller, subjects_controller: {  }
    assert_redirected_to subjects_controller_path(assigns(:subjects_controller))
  end

  test "should destroy subjects_controller" do
    assert_difference('SubjectsController.count', -1) do
      delete :destroy, id: @subjects_controller
    end

    assert_redirected_to subjects_controllers_path
  end
end
