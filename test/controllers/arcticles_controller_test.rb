require 'test_helper'

class ArcticlesControllerTest < ActionController::TestCase
  setup do
    @arcticle = arcticles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:arcticles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create arcticle" do
    assert_difference('Arcticle.count') do
      post :create, arcticle: { body: @arcticle.body, references: @arcticle.references, title: @arcticle.title }
    end

    assert_redirected_to arcticle_path(assigns(:arcticle))
  end

  test "should show arcticle" do
    get :show, id: @arcticle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @arcticle
    assert_response :success
  end

  test "should update arcticle" do
    patch :update, id: @arcticle, arcticle: { body: @arcticle.body, references: @arcticle.references, title: @arcticle.title }
    assert_redirected_to arcticle_path(assigns(:arcticle))
  end

  test "should destroy arcticle" do
    assert_difference('Arcticle.count', -1) do
      delete :destroy, id: @arcticle
    end

    assert_redirected_to arcticles_path
  end
end
