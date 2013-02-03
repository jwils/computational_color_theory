require 'test_helper'

class QuizzesControllerTest < ActionController::TestCase
  setup do
    @quiz = quizzes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quizzes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quiz" do
    assert_difference('Quiz.count') do
      post :create, quiz: { end_time: @quiz.end_time, ip_address: @quiz.ip_address, ruler_height: @quiz.ruler_height, ruler_width: @quiz.ruler_width, start_time: @quiz.start_time, validation_hash: @quiz.validation_hash, worker_id: @quiz.worker_id }
    end

    assert_redirected_to quiz_path(assigns(:quiz))
  end

  test "should show quiz" do
    get :show, id: @quiz
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @quiz
    assert_response :success
  end

  test "should update quiz" do
    put :update, id: @quiz, quiz: { end_time: @quiz.end_time, ip_address: @quiz.ip_address, ruler_height: @quiz.ruler_height, ruler_width: @quiz.ruler_width, start_time: @quiz.start_time, validation_hash: @quiz.validation_hash, worker_id: @quiz.worker_id }
    assert_redirected_to quiz_path(assigns(:quiz))
  end

  test "should destroy quiz" do
    assert_difference('Quiz.count', -1) do
      delete :destroy, id: @quiz
    end

    assert_redirected_to quizzes_path
  end
end
