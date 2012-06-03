class ComentariosController < ApplicationController
  require "exceptions.rb"

  require 'logger'

  def log_ini
    $log=Logger.new('log.xml')
    config.log_level = :info
    config.log_level = :error
    config.log_level = :warn
  end

  # GET /comentarios
  # GET /comentarios.xml
  def view
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo view de comentarios, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} "}
    @users= User.all
    @comentarios = Comentario.all
    respond_to do |format|      
      format.xml { render xml: @comentarios }
    end
  rescue Exception=>e
    mensajesalida = Mensaje.new
    mensajesalida.salida = "Usuario Invalido"
    $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo view --> controlador cometarios"  }
    respond_to do |format|
      format.xml { render xml: mensajesalida }
    end
  end

  def tagfilter
    #@users= User.all
    #@comentarios = Comentario.all
    @tags = (params[:tags])
    respond_to do |format|      
      format.xml { render xml: @tags }
    end
  end
  # GET /comentarios
  # GET /comentarios.xml
  def index
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo index de comentarios, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} "}
    @user = User.find(params[:user_id])
    if (@user == nil)
      mensajesalida = Mensaje.new
      mensajesalida.salida = "Usuario Incorrecto"
      $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo index --> controlador cometarios"  }
      respond_to do |format|
        format.xml { render xml: mensajesalida }
      end
      #      raise Exception.new()
    else
      @comentarios = @user.comentarios
      $log.info("log") {"Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Validando que existan comentarios --> estoy en el metodo index --> controlador cometarios"  }
      if (@comentarios.size > 0)
        respond_to do |format|          
          format.xml { render xml: @comentarios }
        end
      else
        mensajesalida = Mensaje.new
        mensajesalida.salida = "No existen comentarios"
        $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo index de comentarios --> controlador cometarios"  }
        respond_to do |format|
          format.xml { render xml: mensajesalida }
        end
      end
    end    
  rescue Exception=>e
    mensajesalida = Mensaje.new
    mensajesalida.salida = "Usuario Invalido"
    $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo index de comentarios --> controlador cometarios"  }
    respond_to do |format|
      format.xml { render xml: mensajesalida }
    end
  end

  # GET /comentarios/1
  # GET /comentarios/1.xml
  def show
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo show de comentarios, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} "}
    @user = User.find(params[:user_id])
    $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Se valida que el usuario no sea nulo --> estoy en el metodo show de comentarios --> controlador comentarios"  }
    if (@user == nil)
      mensajesalida = Mensaje.new
      mensajesalida.salida = "Usuario Incorrecto"
      $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo show --> controlador cometarios"  }
      respond_to do |format|
        format.xml { render xml: mensajesalida }
      end      
    else
      if (params[:id]=="view")
        @users= User.all
        @comentarios = Comentario.all
        respond_to do |format|          
          format.xml { render xml: @comentario }
        end
      else

        @comentario = @user.comentarios.find(params[:id])
        count_me_gusta=0
        count_no_me_gusta=0
        for puntuacion in @comentario.puntuaciones
          if puntuacion.me_gusta == 1
            count_me_gusta=count_me_gusta+1
          end
          if puntuacion.no_me_gusta == 1
            count_no_me_gusta=count_no_me_gusta+1
          end
        end
        @comentario.me_gusta=count_me_gusta
        @comentario.no_me_gusta=count_no_me_gusta
        $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Se totaliza la puntuacion ME GUSTA, NO ME GUSTA del comentario --> estoy en el metodo show --> controller comentariios"  }
        @comentario.save
        respond_to do |format|          
          format.xml { render xml: @comentario }
        end
      end
    end
  rescue Exception=>e
    mensajesalida = Mensaje.new
    mensajesalida.salida = "Usuario o Comentario Invalido"
    $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo show --> controlador cometarios"  }
    respond_to do |format|
      format.xml { render xml: mensajesalida }
    end
  end

  # GET /comentarios/new
  # GET /comentarios/new.xml
  def new
    @comentario = Comentario.new
    respond_to do |format|      
      format.xml { render xml: @comentario }
    end
  end

  # GET /comentarios/1/edit
  def edit
    @comentario = Comentario.find(params[:id])
  end

  # POST /comentarios
  # POST /comentarios.xml 
  def create
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo create de comentarios, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} "}
    @user = User.find(params[:user_id])
    $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Se valida que el usuario no sea nulo --> estoy en el metodo create de comentarios --> controlador comentarios"  }
    if (@user == nil)
      mensajesalida = Mensaje.new
      mensajesalida.salida = "Usuario Incorrecto"
      $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo create --> controlador cometarios"  }
      respond_to do |format|
        format.xml { render xml: mensajesalida }
      end
      #      raise Exception.new()
    else
      $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Se invoca al metodo valida_session, se le pasan los parametro: #{@user.nick_name},#{request.remote_ip} --> estoy en el metodo create --> controller comentarios"}
      user_control = UsersController.new
      user_control.valida_session(@user, request.remote_ip)
      @miArreglo = []
      @comentario = Comentario.new(params[:comentario])
      if (@comentario.admite_respuesta == nil)
        @comentario.admite_respuesta = true
      end
      @comentario.hora_publicacion = Time.new.to_s
      @miArreglo=[@comentario];
      @user.comentarios.push(@miArreglo)
      $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Se ha registrado exitosamente los valores siguientes valores de usuario: #{@user.attributes.inspect} "  }
      @user.save
      respond_to do |format|        
        format.xml { render xml: @comentario}
      end
    end
    
  rescue Exceptions::BusinessException => be
    mensajesalida = Mensaje.new
    mensajesalida.salida = be.message
    $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo create --> controlador cometarios"  }
    respond_to do |format|
      format.xml { render xml: mensajesalida }
    end    
  rescue Exception => e
    mensajesalida = Mensaje.new
    mensajesalida.salida = e.message
    $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo create --> controlador cometarios"  }
    respond_to do |format|
      format.xml { render xml: mensajesalida }
    end    
  end

  # PUT /comentarios/1
  # PUT /comentarios/1.xml
  def update
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo update del usuario, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} "}
    @user = User.find(params[:user_id])
    if (@user == nil)
      mensajesalida = Mensaje.new
      mensajesalida.salida = "Usuario Incorrecto"
      $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo update --> controlador cometarios"  }
      respond_to do |format|
        format.xml { render xml: mensajesalida }
      end
      #      raise Exception.new("Usuario Incorrecto")
    else
      $log.info("log") {"info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> llamando a valida sesion --> controlador cometarios"  }
      user_control = UsersController.new
      user_control.valida_session(@user, request.remote_ip)
      @comentario = @user.comentarios.find(params[:id])
      @arrayComentario = @user.comentarios
      respond_to do |format|
        if @comentario.update_attributes(params[:comentario])                    
          $log.info("log") {"info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> Comentario modificado con exito --> controlador cometarios"  }
          format.xml { render xml: @comentario }
        else
          $log.error("log") {"error -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> Error modificando el Comentario --> controlador cometarios"  }
          mensajesalida = Mensaje.new
          mensajesalida.salida = @comentario.errors
          respond_to do |format|            
            format.xml { render xml: mensajesalida }
          end          
        end
      end
    end
  rescue Exceptions::BusinessException => be
    mensajesalida = Mensaje.new
    mensajesalida.salida = be.message
    $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo update --> controlador cometarios"  }
    respond_to do |format|
      format.xml { render xml: mensajesalida }
    end
    #    raise Exceptions::BusinessException.new(be.message)
  rescue Exception=>e
    mensajesalida = Mensaje.new
    mensajesalida.salida = "id_usuario o id_comentario Invalido"
    $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo update --> controlador cometarios"  }
    respond_to do |format|
      format.xml { render xml: mensajesalida }
    end    
  end

  def respuesta
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo respuesta de comentarios, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} "}
    @user = User.find(params[:user_id])
    @comentario = Comentario.find(params[:comentario_id])
    if (@user == nil)
      mensajesalida = Mensaje.new
      mensajesalida.salida = "Usuario Incorrecto"
      $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo respuesta --> controlador cometarios"  }
      respond_to do |format|
        format.xml { render xml: mensajesalida }
      end      
    else
      if (@comentario == nil)
        mensajesalida = Mensaje.new
        mensajesalida.salida = "Comentario Padre Incorrecto"
        $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo respuesta --> controlador cometarios"  }
        respond_to do |format|
          format.xml { render xml: mensajesalida }
        end
      else
        user_control = UsersController.new
        user_control.valida_session(@user, request.remote_ip)
        if @comentario.admite_respuesta == false
          mensajesalida = Mensaje.new
          mensajesalida.salida = "El comentario no admite respuesta"
          $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo respuesta --> controlador cometarios"  }
          respond_to do |format|
            format.xml { render xml: mensajesalida }
          end          
        else
          @comentario_nuevo = Comentario.new(params[:comentario])
          @comentario_nuevo.user_id=@user.id
          @comentario_nuevo.hora_publicacion = Time.new
          if (@comentario_nuevo.admite_respuesta == nil)
            @comentario_nuevo.admite_respuesta = true
          end
          #    @comentario_nuevo.comentario_id = @comentario.id
          @arreglo = []
          if @comentario.comentarios == []
            @comentario.comentarios = []
          end
          @arreglo = [@comentario_nuevo]
          @comentario.comentarios.push(@arreglo)
          $log.info("log") {"Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Se guarda existosamente el comentario, teniendo los siguientes paramentros: #{@comentario.attributes.inspect} --> estoy en el metodo respuesta --> controlador cometarios"  }
          @comentario.save
          respond_to do |format|            
            format.xml { render xml: @comentario }
          end
        end
      end
    end
  rescue Exception=>e
    mensajesalida = Mensaje.new
    mensajesalida.salida = e.message
    $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo respuesta --> controlador cometarios"  }
    respond_to do |format|
      format.xml { render xml: mensajesalida }
    end
  end

  def get_comentarios_hijos
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo get_comentarios_hijos, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} " }
    comentarios = Comentario.all
    array_hijos = []    
    for comentario in comentarios
      if (!comentario.comentario_id.nil?)
        if (comentario.comentario_id.to_s == params[:comentario_id].to_s)
          array_hijos.push(comentario)          
        end
      end
    end
    $log.info("log") { "Info -- " "Retornando los comentarios hijos, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}"}
    respond_to do |format|      
      format.xml { render xml: array_hijos }
    end
  end

  def eliminar_hijos (usuario, comentario_padre)
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo get_comentarios_hijos, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} " }
    comentarios = Comentario.all
    for comentario in comentarios
      if (!comentario.comentario_id.nil?)
        if (comentario.comentario_id.to_s == comentario_padre.id.to_s)
          comentario_eliminar = usuario.comentarios.find(comentario.id)
          comentario_eliminar.destroy
        end
      end
    end

  end

  # DELETE /comentarios/1
  # DELETE /comentarios/1.xml
  def destroy
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo destroy de los tags, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}"}
    @user = User.find(params[:user_id])
    if (@user == nil)
      mensajesalida = Mensaje.new
      mensajesalida.salida = "Usuario Incorrecto"
      $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo destroy --> controlador cometarios"  }
      respond_to do |format|
        format.xml { render xml: mensajesalida }
      end
      #      raise Exception.new("Usuario Incorrecto")
    else
      $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Se invoca al metodo valida_session, se le pasan los parametro: #{@user.nick_name},#{request.remote_ip} --> estoy en el metodo destroy comentarios --> controlador comentarios"}
      user_control = UsersController.new
      user_control.valida_session(@user, request.remote_ip)
      @comentario = @user.comentarios.find(params[:id])
      eliminar_hijos(@user, @comentario)
      @comentario.destroy
      mensajesalida = Mensaje.new
      mensajesalida.salida = "Comentario Eliminado con exito"
      $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo destroy --> controlador cometarios"  }
      respond_to do |format|
        format.xml { render xml: mensajesalida }
      end
    end
  rescue Exceptions::BusinessException => be
    mensajesalida = Mensaje.new
    mensajesalida.salida = be.message
    $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo destroy --> controlador cometarios"  }
    respond_to do |format|
      format.xml { render xml: mensajesalida }
    end
    #    raise Exceptions::BusinessException.new(be.message)
  rescue Exception=>e
    mensajesalida = Mensaje.new
    mensajesalida.salida = "Usuario o Comentario Invalido"
    $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo destroy --> controlador cometarios"  }
    respond_to do |format|
      format.xml { render xml: mensajesalida }
    end
    #    raise Exception.new()
  end 
end