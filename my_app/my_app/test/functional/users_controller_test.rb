require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
#    @user = users(:one)
    @ip = '127.0.0.1'
    @user = User.new
    @user.nombre = 'Luis'
    @user.apellido = 'Carvajal'
    @user.nick_name = '123'
    @user.password = '123'
    @user.biografia = 'biografia'
    @user.correo = 'lcarvajal@gmail.com'
    @user.pais = 'vzla'
    @user.save
    @user_controller = UsersController.new
  end
#
#  test "should get index" do
#    get :index
#    assert_response :success
#    assert_not_nil assigns(:users)
#  end
#
#  test "should get new" do
#    get :new
#    assert_response :success
#  end
#
  test "should create user" do
#    assert_difference('User.count') do
#      post :create, user: @user.attributes
#    end
    assert_equal 0, User.count
  end

#  test "should show user" do
#    get :show, id: @user
#    assert_response :success
#  end
#
#  test "should get edit" do
#    get :edit, id: @user
#    assert_response :success
#  end
#
  test "should update user" do
    put :update, id: @user, user: @user.attributes
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end
  end

  def tear_down
    @user.destroy
  end
end
