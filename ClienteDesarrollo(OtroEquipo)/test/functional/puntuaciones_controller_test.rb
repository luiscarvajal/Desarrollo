require 'test_helper'

class PuntuacionesControllerTest < ActionController::TestCase
  setup do
    @puntuacione = puntuaciones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:puntuaciones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create puntuacione" do
    assert_difference('Puntuacione.count') do
      post :create, puntuacione: @puntuacione.attributes
    end

    assert_redirected_to puntuacione_path(assigns(:puntuacione))
  end

  test "should show puntuacione" do
    get :show, id: @puntuacione
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @puntuacione
    assert_response :success
  end

  test "should update puntuacione" do
    put :update, id: @puntuacione, puntuacione: @puntuacione.attributes
    assert_redirected_to puntuacione_path(assigns(:puntuacione))
  end

  test "should destroy puntuacione" do
    assert_difference('Puntuacione.count', -1) do
      delete :destroy, id: @puntuacione
    end

    assert_redirected_to puntuaciones_path
  end
end
