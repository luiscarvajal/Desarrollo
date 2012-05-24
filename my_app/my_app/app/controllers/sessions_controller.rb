class SessionsController < ApplicationController
  def index
    @misession = Session.new
  end
  def create
    @sessiones = Session.all
    @misession = Session.new(params[:session])
    for sesion in @sessiones
      if sesion.nick_name == @misession.nick_name
         sesion.delete
      end
    end
    @users=User.all
    flag = false
    for user in @users
      if user.nick_name == @misession.nick_name and user.password == @misession.password
        flag = true
      end
    end
    if flag == true
      @misession.save
      respond_to do |format|
        format.html { redirect_to @misession, notice: 'User was successfully created.' }
        format.json { render json: @misession, status: :created, location: @misession }
      end
    else
      miusuario=User.new
      miusuario.nombre="Los eficiencia uno me lo croman!"
      respond_to do |format|
        format.html { redirect_to miusuario, notice: 'ERROR' }
        format.json { render json: miusuario, status: :created, location: miusuario }
      end
    end

  end

  def show
    @misession = Session.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @misession }
      format.xml { render xml: @misession }
    end
  end
end
