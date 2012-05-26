class UsersController < ApplicationController
  require "exceptions.rb"
  # GET /users
  # GET /users.json
  def index

    @users = User.all
    if @users.size > 0
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @users }
        format.xml { render xml: @users}
      end
    else
      raise Exceptions::BusinessException.new("No existen usuarios")
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    if (@user == nil)
      raise Exception.new("Id usuario Incorrecto")
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
      format.xml { render xml: @user }
    end
  rescue Exception=>e
    raise Exceptions::BusinessException.new(e.message)
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
    valida_session(@user, request.remote_ip)
    respond_to do |format|
      if @user.update_attributes(params[:user])        
        format.json { render json: @user }
        format.xml { render xml: @user }
      else
        raise Exceptions::BusinessException.new(@user.errors)
      end
    end
  rescue Exceptions::BusinessException => be
    raise Exceptions::BusinessException.new(be.message)
  rescue Exception=>e
    raise Exceptions::BusinessException.new("id_usuario incorrecto")
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy    
    @user = User.find(params[:id])
    if @user == nil
      raise Exception.new("id_usuario incorrecto")
    end
    valida_session(@user, request.remote_ip)
    if @user.delete
      @user = User.new
      @user.mensaje = "Usuario Eliminado con exito"
      respond_to do |format|
        format.json { render json: @user }
        format.xml { render xml: @user }
      end
    else
      raise Exception.new("Ocurrio un Error")
    end
  rescue Exceptions::BusinessException => be
     raise Exceptions::BusinessException.new(be.message)
  rescue Exception=>e
    raise Exception.new(e.message)
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

  def solicitar_token (usuario)    
    @mitoken = Token.new
    @mitoken.status = 'activo'
    @mitoken.hora_ini = Time.new.to_s
    @mitoken.ip = request.remote_ip
    flag = true
    @tokenout = Token.new

    for token in usuario.tokens
      /si la dif es menor retorno el token activo correspondiente a la ip/
      if ((@mitoken.hora_ini.to_time - token.hora_ini.to_time)<300)
        if (@mitoken.ip == token.ip)
          @tokenout = token
          flag = false
        end
      else
        if (@mitoken.ip == token.ip)
          usuario.tokens.delete_if { |tokenin| tokenin.id == token.id}
          usuario.save
          raise "El token esta vencido"
        end
      end
    end
    if flag == true
      usuario.tokens.push(@mitoken)
      @tokenout = @mitoken
      @tokenout.mensaje = "El token solicitado es:"+ @tokenout.id
      usuario.save
    else
      raise "Existe un token vigente"
    end
    return @mitoken    
  end

  def login    
    @users=User.all
    @misession = Session.new(params[:session])
    flag = false
    @miusuario = User.new
    for user in @users
      if (user.password == @misession.password) and (user.nick_name == @misession.nick_name)
        @miusuario = user
        flag = true
      end
    end
    
    if flag == true
      @token = solicitar_token(@miusuario)
      respond_to do |format|
        format.json { render json: @miusuario}
      end
    else
      miusuario=User.new
      miusuario.nombre="Nombre de usuario o contraseña incorrectos"
      respond_to do |format|
        format.html { redirect_to miusuario, notice: 'ERROR' }
        format.json { render json: miusuario, status: :created, location: miusuario }
      end
    end
  end

  def valida_session(usuario, ip)    
    @token
    for token_i in usuario.tokens
      if token_i.ip == ip
         @token = token_i
      end
    end
    if ((Time.new - @token.hora_ini.to_time)>300)
      usuario.tokens.delete_if { |token| token.id == @token.id}
      usuario.save
      raise Exceptions::BusinessException.new("El token se ha vencido")
    end
  rescue Exception=>be
    raise Exceptions::BusinessException.new("No hay token Vigente")
 end

end
