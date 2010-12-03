require 'test_helper'

class ToysControllerTest < ActionController::TestCase
  setup do
    @toy = toys(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:toys)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create toy" do
    assert_difference('Toy.count') do
      post :create, :toy => @toy.attributes
    end

    assert_redirected_to toy_path(assigns(:toy))
  end

  test "should show toy" do
    get :show, :id => @toy.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @toy.to_param
    assert_response :success
  end

  test "should update toy" do
    put :update, :id => @toy.to_param, :toy => @toy.attributes
    assert_redirected_to toy_path(assigns(:toy))
  end

  test "should destroy toy" do
    assert_difference('Toy.count', -1) do
      delete :destroy, :id => @toy.to_param
    end

    assert_redirected_to toys_path
  end
end
