require 'test_helper'

class ScreenShotsControllerTest < ActionController::TestCase
  setup do
    @screen_shot = screen_shots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:screen_shots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create screen_shot" do
    assert_difference('ScreenShot.count') do
      post :create, screen_shot: { directory: @screen_shot.directory, from: @screen_shot.from, until: @screen_shot.until, uuid: @screen_shot.uuid }
    end

    assert_redirected_to screen_shot_path(assigns(:screen_shot))
  end

  test "should show screen_shot" do
    get :show, id: @screen_shot
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @screen_shot
    assert_response :success
  end

  test "should update screen_shot" do
    put :update, id: @screen_shot, screen_shot: { directory: @screen_shot.directory, from: @screen_shot.from, until: @screen_shot.until, uuid: @screen_shot.uuid }
    assert_redirected_to screen_shot_path(assigns(:screen_shot))
  end

  test "should destroy screen_shot" do
    assert_difference('ScreenShot.count', -1) do
      delete :destroy, id: @screen_shot
    end

    assert_redirected_to screen_shots_path
  end
end
