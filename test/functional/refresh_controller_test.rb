require 'test_helper'

class RefreshControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get everyone" do
    get :everyone
    assert_response :success
  end

  test "should get tags" do
    get :tags
    assert_response :success
  end

  test "should get popular" do
    get :popular
    assert_response :success
  end

  test "should get debuts" do
    get :debuts
    assert_response :success
  end

end
