require 'test_helper'

class ModulePacksControllerTest < ActionController::TestCase
  setup do
    @module_pack = module_packs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:module_packs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create module_pack" do
    assert_difference('ModulePack.count') do
      post :create, module_pack: { name: @module_pack.name, unit_id: @module_pack.unit_id }
    end

    assert_redirected_to module_pack_path(assigns(:module_pack))
  end

  test "should show module_pack" do
    get :show, id: @module_pack
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @module_pack
    assert_response :success
  end

  test "should update module_pack" do
    patch :update, id: @module_pack, module_pack: { name: @module_pack.name, unit_id: @module_pack.unit_id }
    assert_redirected_to module_pack_path(assigns(:module_pack))
  end

  test "should destroy module_pack" do
    assert_difference('ModulePack.count', -1) do
      delete :destroy, id: @module_pack
    end

    assert_redirected_to module_packs_path
  end
end
