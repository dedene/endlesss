require 'test_helper'

class ShotsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show_by_feed" do
    get :show_by_feed
    assert_response :success
  end

end
