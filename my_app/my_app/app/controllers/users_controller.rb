class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index

    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
      format.xml { render xml: @users}
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
      format.xml { render xml: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
      format.xml { render xml: @user}
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    if (!valida_nick_name(@user.nick_name))
        respond_to do |format|
          if @user.save
            format.html { redirect_to @user, notice: 'User was successfully created.' }
            format.json { render json: @user, status: :created, location: @user }
          else
            format.html { render action: "new" }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end
    else
        @user = User.new
        @user.mensaje = "El nickname ya existe"
        respond_to do |format|
          format.json { render json: @user }
          format.xml { render xml: @xml }
        end
    end
  rescue Exception=>e
      @user = User.new
      @user.mensaje = "ERROR USUARIO"
      respond_to do |format|
        format.json { render json: @user }
        format.xml { render xml: @xml }
      end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.delete

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def valida_nick_name (nick)
    @users = User.all
    flag = false;
    for user in @users
      if user.nick_name == nick
        flag = true
      end
    end
    return flag
  end

  def valida_datos_usuario (userin)

    if userin.nombre == ""
      return "falta el nombre"
    end
    if "" == userin.apellido
      return "falta el apellido"
    end
    if user.password == user.password_confirmacion and user.password != ""
      return "error en el password"
    end
    if "" == userin.correo
      return "falta el correo"
    end
    if "" == userin.fechaNacimiento
      return "falta la fecha de nacimiento"
    end
  end

  def login     
    @users=User.all
    @misession = params[:session]
    flag = false    
    for user in @users
      if (user.password == @misession.password)
        @miusuario = user
        flag = true
      end
    end
    if flag == true
      token = Token.create(@miusuario)
      respond_to do |format|
        format.html { redirect_to token @miusuario, notice: 'User was successfully created.' }
        format.json { render json: @miusuario, status: :created, location: @misession }
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
end
