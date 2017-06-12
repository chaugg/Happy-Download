require 'test_helper'

class ControllersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controller = controllers(:one)
  end

  test "should get index" do
    get controllers_url
    assert_response :success
  end

  test "should get new" do
    get new_controller_url
    assert_response :success
  end

  test "should create controller" do
    assert_difference('Controller.count') do
      post controllers_url, params: { controller: { profile: @controller.profile } }
    end

    assert_redirected_to controller_url(Controller.last)
  end

  test "should show controller" do
    get controller_url(@controller)
    assert_response :success
  end

  test "should get edit" do
    get edit_controller_url(@controller)
    assert_response :success
  end

  test "should update controller" do
    patch controller_url(@controller), params: { controller: { profile: @controller.profile } }
    assert_redirected_to controller_url(@controller)
  end

  test "should destroy controller" do
    assert_difference('Controller.count', -1) do
      delete controller_url(@controller)
    end

    assert_redirected_to controllers_url
  end
end
