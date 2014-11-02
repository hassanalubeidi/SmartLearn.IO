require 'test_helper'

class ImprovementsControllerTest < ActionController::TestCase
  setup do
    @improvement = improvements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:improvements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create improvement" do
    assert_difference('Improvement.count') do
      post :create, improvement: { area_to_improve: @improvement.area_to_improve, checked: @improvement.checked, topic: @improvement.topic, user_id: @improvement.user_id }
    end

    assert_redirected_to improvement_path(assigns(:improvement))
  end

  test "should show improvement" do
    get :show, id: @improvement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @improvement
    assert_response :success
  end

  test "should update improvement" do
    patch :update, id: @improvement, improvement: { area_to_improve: @improvement.area_to_improve, checked: @improvement.checked, topic: @improvement.topic, user_id: @improvement.user_id }
    assert_redirected_to improvement_path(assigns(:improvement))
  end

  test "should destroy improvement" do
    assert_difference('Improvement.count', -1) do
      delete :destroy, id: @improvement
    end

    assert_redirected_to improvements_path
  end
end
