class UsersController < ApplicationController
  require "exceptions.rb"
  
  require 'logger'

  def log_ini
    $log=Logger.new('log.xml')
    config.log_level = :info
    config.log_level = :error
    config.log_level = :warn
  end

  # GET /users
  # GET /users.xml
  def index
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo index del usuario, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}"}
    @users = User.all
    if @users.size > 0
      respond_to do |format|
        format.xml { render xml: @users}
      end
    else
      mensajesalida = Mensaje.new
      $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. No existen usuarios --> estoy en el index"  }
      mensajesalida.salida = "No existen usuarios"
      respond_to do |format|
        format.xml { render xml: mensajesalida}
      end
      #      raise Exceptions::BusinessException.new("No existen usuarios")
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo show del usuario, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} "}
    @user = User.find(params[:id])
    if (@user == nil)
      #      raise Exception.new("Id usuario Incorrecto")
      mensajesalida = Mensaje.new
      $log.error("log") { "Error -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Ha ocurrido un error, el Id del usuario: #{@user.id} es incorrecto --> estoy en el metodo show" }
      mensajesalida.salida = "Id usuario Incorrecto"
      respond_to do |format|        
        format.xml { render xml: mensajesalida}
      end
    end
    respond_to do |format|
      format.xml { render xml: @user }
    end
  rescue Exception=>e
    mensajesalida = Mensaje.new
    $log.error("log") { "Error -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Ha ocurrido un error--> estoy en el metodo show" }
    mensajesalida.salida = e.message
    respond_to do |format|
      format.xml { render xml: mensajesalida}
    end
    #    raise Exceptions::BusinessException.new(e.message)
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.xml { render xml: @user}
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    log_ini
    @user = User.new(params[:user])
    $log.info("log") { "Info -- " "Entrando en el metodo de crear del usuario, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} "}
    $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Se invoca al metodo para valida_nick_name, se le pasa el parametro: #{@user.nick_name} --> estoy en el metodo create "}
    if (!valida_nick_name(@user.nick_name))
      respond_to do |format|
        if @user.save
          $log.info("log") { "Info -- " "El usuario ha sido registrado exitosamente el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}, sus datos son: #{@user.attributes.inspect} --> estoy en el metodo create" }
          format.xml { render xml: @user, status: :created}
        else
          $log.error("log") { "Error -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Ha ocurrido un error, el nick_name #{@user.nick_name} --> estoy en el metodo create"}
          format.xml { render xml: @user.errors }
        end
      end
    else
      mensajesalida = Mensaje.new
      $log.error("log") { "Error -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Ha ocurrido un error, el nick_name #{@user.nick_name} ya existe --> estoy en el metodo create"}
      mensajesalida.salida = "El nickname ya existe"
      respond_to do |format|
        format.xml { render xml: mensajesalida }
      end
    end
  rescue Exception=>e
    mensajesalida = Mensaje.new
    $log.error("log") { "Error -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Ha ocurrido un erro, #{mensajesalida.salida} --> estoy en el metodo create "  }
    mensajesalida.salida = "ERROR USUARIO"
    respond_to do |format|
      format.xml { render xml: mensajesalida }
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    log_ini
    @user = User.find(params[:id])
    $log.info("log") { "Info -- " "Entrando en el update del usuario, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} "}
    $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Se invoca al metodo valida_session, se le pasan los parametro: #{@user.nick_name},#{request.remote_ip} --> estoy en el metodo update "}
    valida_session(@user, request.remote_ip)
    respond_to do |format|
      if @user.update_attributes(params[:user])        
        $log.info("log") { "Info -- " "El usuario ha sido modificado exitosamente el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}, sus datos son: #{@user.attributes.inspect} --> estoy en el metodo update" }
        format.xml { render xml: @user }
      else
        mensajesalida = Mensaje.new
        mensajesalida.salida = @user.errors
        $log.error("log") { "Error -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Ha ocurrido un error, #{mensajesalida.salida} --> estoy en el metodo update "  }
        respond_to do |format|
          format.xml { render xml: mensajesalida}
        end
        #        raise Exceptions::BusinessException.new(@user.errors)
      end
    end
  rescue Exceptions::BusinessException => be
    mensajesalida = Mensaje.new
    mensajesalida.salida = be.message
    $log.error("log") { "Error -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Ha ocurrido un error, #{mensajesalida.salida} --> estoy en el metodo update "  }
    respond_to do |format|
      format.xml { render xml: mensajesalida}
    end
    #    raise Exceptions::BusinessException.new(be.message)
  rescue Exception=>e
    mensajesalida = Mensaje.new
    mensajesalida.salida = "id_usuario incorrecto"
    $log.error("log") { "Error -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Ha ocurrido un error, #{mensajesalida.salida} --> estoy en el metodo update "  }
    respond_to do |format|
      format.xml { render xml: mensajesalida}
    end
    #    raise Exceptions::BusinessException.new("id_usuario incorrecto")
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy    
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo de eliminar un usuario, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} " }
    @user = User.find(params[:id])
    if @user == nil
      mensajesalida = Mensaje.new
      mensajesalida.salida = "id_usuario incorrecto"
      $log.info("log") { "Error -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Ha ocurrido un error: #{mensajesalida.salida} --> estoy en el metodo destroy"}
      respond_to do |format|
        format.xml { render xml: mensajesalida}
      end
      #      raise Exception.new("id_usuario incorrecto")
    else
     $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Se invoca al metodo valida_session, se le pasan los parametro: #{@user.nick_name},#{request.remote_ip} --> estoy en el metodo destroy "}
     valida_session(@user, request.remote_ip)
      if @user.delete
        mensajesalida = Mensaje.new
        mensajesalida.salida = "Usuario Eliminado con exito"
        $log.info("log") {"Info -- " "#{mensajesalida.salida} el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} sus datos eran: #{@user.attributes.inspect} --> estoy en el metodo destroy" }
        respond_to do |format|
          format.xml { render xml: mensajesalida }
        end
      else
        mensajesalida = Mensaje.new
        mensajesalida.salida = "Ocurrio un Error"
        $log.error("log") { "Error -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Ha ocurrido un error --> estoy en el metodo destroy"  }
        respond_to do |format|
          format.xml { render xml: mensajesalida}
        end
      end
    end
  rescue Exceptions::BusinessException => be
    mensajesalida = Mensaje.new
    mensajesalida.salida = be.message
    $log.error("log") { "Error -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Ha ocurrido un error, #{mensajesalida.salida} --> estoy en el metodo destroy "  }
    respond_to do |format|
      format.xml { render xml: mensajesalida}
    end    
  rescue Exception=>e
    mensajesalida = Mensaje.new
    mensajesalida.salida = e.message
    $log.error("log") { "Error -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Ha ocurrido un error, #{mensajesalida.salida} --> estoy en el metodo destroy "  }
    respond_to do |format|
      format.xml { render xml: mensajesalida}
    end    
  end

  def valida_nick_name (nick)
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo valida_nick_name del usuario, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} "}
    @users = User.all
    flag = false;
    for user in @users
      if user.nick_name == nick
        flag = true
        $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. El usuario #{user.nick_name} si existe --> estoy en el metodo valida_nick_name"}
        break
      end
    end
    return flag
  end

  def valida_datos_usuario (userin)
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo de eliminar un usuario, el dia #{Time.now} " }

    if userin.nombre == ""
      $log.warn("log") { "Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} se ha dejado el campo de nombre en blanco --> estoy en el metodo valida_datos_usuario" }
      return "falta el nombre"
    end
    if "" == userin.apellido
      $log.warn("log") { "Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} se ha dejado el campo de apellido en blanco --> estoy en el metodo valida_datos_usuario" }
      return "falta el apellido"
    end
    if user.password == user.password_confirmacion and user.password != ""
      $log.error("log") { "Error -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} las contraseñas no coinciden --> estoy en el metodo valida_datos_usuario" }
      return "error en el password"
    end
    if "" == userin.correo
      $log.warn("log") { "Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} se ha dejado el campo de correo electronico en blanco --> estoy en el metodo valida_datos_usuario" }
      return "falta el correo"
    end
    if "" == userin.fechaNacimiento
      $log.warn("log") { "Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} se ha dejado el campo de fecha de de nacimiento en blanco --> estoy en el metodo valida_datos_usuario" }
      return "falta la fecha de nacimiento"
    end
  end

  def solicitar_token (usuario)    
    log_ini
    @mitoken = Token.new
    $log.info("log") { "Info -- " "Entrando en el metodo solicitar token, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}" }
    @mitoken.status = 'activo'
    @mitoken.hora_ini = Time.new.to_s
    @mitoken.ip = request.remote_ip
    $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. El status del token es activo, posee los siguientes datos: #{@mitoken.attributes.inspect} --> estoy en el metodo solicitar_token " }
    flag = true
    @tokenout = Token.new
    $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Se procede a validar si el token esta activo o vencido para la siguiente direccion ip #{@mitoken.ip} --> estoy en el metodo solicitar_token" }
    for token in usuario.tokens
      /si la dif es menor retorno el token activo correspondiente a la ip/
      if ((@mitoken.hora_ini.to_time - token.hora_ini.to_time)<300)
        if (@mitoken.ip == token.ip)
          @tokenout = token
          flag = false
          $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. El token sigue activo --> estoy en el metodo solicitar_token" }
       end
      else
        if (@mitoken.ip == token.ip)
          usuario.tokens.delete_if { |tokenin| tokenin.id == token.id}
          usuario.save          
          $log.error("log") { "Error -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. El token esta vencido --> estoy en el metodo solicitar_token. " }
        end
      end
    end
    if (flag == true)
      usuario.tokens.push(@mitoken)
      @tokenout = @mitoken
      @tokenout.mensaje = "El token solicitado es:"+ @tokenout.id
      $log.info("log") { "Info -- "  "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. El token solicitado es #{@tokenout.id}v--> estoy en el metodo solicitar_token " }
      usuario.save
    else      
      $log.info("log") { "Info -- "  "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}.Ya existe un token vigente, estoy en el metodo solicitar_token" }
      raise "Existe un token vigente."
    end
    return @mitoken    
  end

  def login    
    log_ini
    @users=User.all
    @misession = Session.new(params[:session])
    $log.info("log") { "Info -- " "Entrando en el metodo login el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}" }
    $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Los datos para iniciar la sesion en el sistema son: #{@misession.attributes.inspect} --> estoy en el metodo login"}
    flag = false
    @miusuario = User.new
    for user in @users
      $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Validando el password y nick_name del usuario --> estoy en el metodo login"  }
      if (user.password == @misession.password) and (user.nick_name == @misession.nick_name)
        @miusuario = user
        flag = true
        break
      end
    end
    if (flag == true)
      $log.info ("log"){"Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Datos correctos, se invoca el metodo solicitar_token, pasandole los siguientes parametros #{@miusuario.nick_name} y #{@miusuario.password} --> estoy en el metodo login "}
      @token = solicitar_token(@miusuario)
      respond_to do |format|
        format.xml { render xml: @miusuario}
      end
    else
      mensajesalida = Mensaje.new
      $log.error ("log"){"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Ha ocurrido un error, #{mensajesalida.salida} --> estoy en el metodo login"}
      mensajesalida.salida = "Usuario o clave incorrecto"
      respond_to do |format|
        format.xml { render xml: mensajesalida}
      end      
    end
  rescue Exception=>e
    mensajesalida = Mensaje.new
    mensajesalida.salida = e.message
    $log.error("log") { "Error -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Ha ocurrido un error, #{mensajesalida.salida} --> estoy en el metodo login "  }
    respond_to do |format|
      format.xml { render xml: mensajesalida}
    end
  end

  def valida_session(usuario, ip)    
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo valida_session el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}" }
    @token
    for token_i in usuario.tokens
      $log.info("log") { "Info -- "+token_i.ip+" "+ip+"#{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}" }
      if token_i.ip == ip
        $log.info("log") { "Info -- " "ya existe un token #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}" }
        @token = token_i
        break
      end
    end
    if ((Time.new - @token.hora_ini.to_time)>300)
      usuario.tokens.delete_if { |token| token.id == @token.id}
      usuario.save
#      raise Exception.new("El token se ha vencido")
      $log.warn("log") { "Warn -- " "El token se ha vencido #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} --> estoy en el metodo valida_session" }
      raise Exceptions::BusinessException.new("El token se ha vencido")
    end
  rescue Exception=>be
    $log.warn("log") { "Warn -- " "No existe token vigente #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} --> estoy en el metodo valida_session" }
    raise Exceptions::BusinessException.new("No hay token Vigente")
#     raise Exception.new("No hay token Vigente")
  end
end