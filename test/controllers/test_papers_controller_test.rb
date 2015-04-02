require 'test_helper'

class TestPapersControllerTest < ActionController::TestCase
  setup do
    @test_paper = test_papers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:test_papers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create test_paper" do
    assert_difference('TestPaper.count') do
      post :create, test_paper: { calc_allowed: @test_paper.calc_allowed, date: @test_paper.date, questions: @test_paper.questions, subject_id: @test_paper.subject_id }
    end

    assert_redirected_to test_paper_path(assigns(:test_paper))
  end

  test "should show test_paper" do
    get :show, id: @test_paper
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @test_paper
    assert_response :success
  end

  test "should update test_paper" do
    patch :update, id: @test_paper, test_paper: { calc_allowed: @test_paper.calc_allowed, date: @test_paper.date, questions: @test_paper.questions, subject_id: @test_paper.subject_id }
    assert_redirected_to test_paper_path(assigns(:test_paper))
  end

  test "should destroy test_paper" do
    assert_difference('TestPaper.count', -1) do
      delete :destroy, id: @test_paper
    end

    assert_redirected_to test_papers_path
  end
end
