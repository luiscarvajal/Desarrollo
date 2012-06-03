require 'test_helper'
require "exceptions.rb"
#require 'fixtures/users.yml'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
#    user = users(:one).find
#    user= users(:one)
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
  
  def test_valida_nick_name
    assert_equal true, @user_controller.valida_nick_name(@user.nick_name)
  end

  def test_valida_sesion
    assert_raise (Exceptions::BusinessException){@user_controller.valida_session(@user, @ip)}
  end

  def teardown
    @user.destroy
  end
end
