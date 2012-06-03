class PuntuacionesController < ApplicationController
  #!C:\Users\LILIANA\Desktop\ultimo servidor desarrollo\Desarrollo\my_app\my_app
  require 'logger'

  before_filter :get_user_comentario

  def log_ini
    $log=Logger.new('log.xml')
    config.log_level = :info
    config.log_level = :error
    config.log_level = :warn
  end

  def get_user_comentario
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo get_user_comentario, controlador puntuaciones, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} "}
    $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Validando que exista el user_id y el comentario_id --> estoy en el metodo get_user_comentario --> controlador de puntuaciones " }
    @user = User.find(params[:user_id])
    @comentario = Comentario.find(params[:comentario_id])
    $log.info("log") {"Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Los id correspondientes son #{@user} y #{@comentario} --> estoy en el metodo get_user_comentario --> controlador de puntuaciones "  }
  end

  def lista_puntuaciones
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo lista_puntuaciones - controlador puntuaciones, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} "}
    @puntuaciones = Puntuacione.all
    $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Validando si existe una lista de puntuaciones --> estoy en el metodo lista_puntuaciones --> controlador puntuaciones" }
    if (@puntuaciones.size > 0)
      $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Si existe una lista de puntuaciones --> estoy en el metodo lista_puntuaciones --> controlador puntuaciones"  }
      respond_to do |format|
        format.xml  { render xml: @puntuaciones }
      end
    else
      mensajesalida = Mensaje.new
      mensajesalida.salida = "No existen Puntuaciones"
      $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo lista_puntuaciones --> controlador puntuaciones"  }
      respond_to do |format|
        format.xml { render xml: mensajesalida }
      end      
    end
  rescue Exception=>e
    mensajesalida = Mensaje.new
    mensajesalida.salida = "A ocurrido un error"
    $log.error("log") {"Error -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo lista_puntuaciones --> controlador puntuaciones"  }
    respond_to do |format|
      format.xml { render xml: mensajesalida }
    end
  end

  # GET /puntuaciones
  # GET /puntuaciones.xml
  def index
    #    @puntuaciones = Puntuacione.all
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo index de lista_puntuaciones - controlador puntuaciones, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} "}
    @puntuaciones = Puntuacione.where(:comentario_id => @comentario.id)

    if (@puntuaciones.size > 0)
      $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Si existe una lista de puntuaciones --> estoy en el metodo index --> controlador puntuaciones"  }
      respond_to do |format|
        format.xml  { render xml: @puntuaciones }
      end
    else
      mensajesalida = Mensaje.new
      mensajesalida.salida = "No existen Puntuaciones"
      $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo index --> controlador puntuaciones"  }
      respond_to do |format|
        format.xml { render xml: mensajesalida }
      end      
    end
    
  rescue Exception=>e
    mensajesalida = Mensaje.new
    mensajesalida.salida = "A ocurrido un error"
    $log.error("log") {"Error -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo index --> controlador puntuaciones"  }
    respond_to do |format|
      format.xml { render xml: mensajesalida }
    end
  end

  # GET /puntuaciones/1
  # GET /puntuaciones/1.xml
  def show

    @puntuacione = Puntuacione.find(params[:id])
    respond_to do |format|      
      format.xml { render xml: @puntuacione }
    end
  end

  # GET /puntuaciones/new
  # GET /puntuaciones/new.xml
  def new
    
    @puntuacione = Puntuacione.new
    respond_to do |format|      
      format.xml { render xml: @puntuacione}
    end
  end

  # GET /puntuaciones/1/edit
  def edit
    @puntuacione = Puntuacione.find(params[:id])
  end

  # POST /puntuaciones
  # POST /puntuaciones.xml
  def create    
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo create de puntuaciones, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}"}
    @user
    @comentario
    $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Se invoca al metodo valida_session, se le pasan los parametro: #{@user.nick_name},#{request.remote_ip} --> estoy en el metodo create --> controller puntuaciones "}
    user_control = UserController.new
    user_control.valida_session(@user,request.remote_ip)
    @puntuacione = Puntuacione.new(params[:puntuacione])
    if (@puntuacione.me_gusta != nil) and (@puntuacione.no_me_gusta != nil)
      mensajesalida = Mensaje.new
      mensajesalida.salida = "No se puede tener mas de un puntaje"
      $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo create --> controlador puntuaciones"  }
      respond_to do |format|
        format.xml { render xml: mensajesalida }
      end
      #      raise Exception.new()
    else
      aux=Puntuacione.all
      flag=false
      for mipuntuacion in aux
        $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Se procede a validar que un usuario vote dos veces --> estoy en el metodo create puntuacion --> controller puntuacion "  }
        if mipuntuacion.user_id == @user.id and mipuntuacion.comentario_id==@comentario.id
          flag=true
        end
      end
      if flag == true
        mensajesalida = Mensaje.new
        mensajesalida.salida = "El usuario ya puntuo ese comentario"
        $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo create de puntuacion --> controlador puntuaciones"  }
        respond_to do |format|
          format.xml { render xml: mensajesalida }
        end
      else
        @puntuacione.comentario_id=@comentario.id
        @puntuacione.user_id=@user.id
        respond_to do |format|
          if @puntuacione.save
            $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo create de puntuacion --> controlador puntuaciones"  }
            @puntuacione.mensaje = "El comentario fue Puntuado Con exito"
            format.xml { render xml: @puntuacione}
          else
            mensajesalida = Mensaje.new
            mensajesalida.salida = [@user,@comentario,@puntuacione].errors
            $log.error("log") {"Error -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo create de puntuacion --> controlador puntuaciones"  }
            format.xml { render xml: mensajesalida }
          end
        end
      end
    end
  rescue Exception=>e
    mensajesalida = Mensaje.new
    mensajesalida.salida = e.message
    $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo create de puntuaciones --> controlador puntuaciones"  }
    respond_to do |format|
      format.xml { render xml: mensajesalida }
    end
  end
  # PUT /puntuaciones/1
  # PUT /puntuaciones/1.xml
  def update
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo update en el controlador puntuaciones, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} "}
    $log.info("log") {"Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Validando que el usuario o el comentario sean nulos --> estoy en el metodo update de puntuacion --> controlador puntuaciones"  }
    if @user==nil or @comentario==nil
      mensajesalida = Mensaje.new
      mensajesalida.salida = "id puntuacion incorrecto"
      $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo update de puntuacion --> controlador puntuaciones"  }
      respond_to do |format|
        format.xml { render xml: mensajesalida }
      end
    else
      $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Se invoca al metodo valida_session, se le pasan los parametro: #{@user.nick_name},#{request.remote_ip} --> estoy en el metodo update --> controlador puntuaciones"}
      user_control = UserController.new
      user_control.valida_session(@user,request.remote_ip)
      @puntuacione = Puntuacione.find(params[:id])
      $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Validando que el atributo puntuacione sea distinto de nul --> estoy en el metodo update --> controlador puntuaciones"}
      if @puntuacione == nil
        mensajesalida = Mensaje.new
        mensajesalida.salida = "id puntuacion incorrecto"
        $log.error("log") { "Error -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Ha ocurrido un error, #{mensajesalida.salida} --> estoy en el metodo update --> controlador puntuaciones"  }
        respond_to do |format|
          format.xml { render xml: mensajesalida }
        end        
      else
        $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Validando que los user_id sean iguales --> estoy en el metodo update --> controlador puntuaciones"}
        if (@puntuacione.user_id == @user.id)
          respond_to do |format|
            if @puntuacione.update_attributes(params[:puntuacione])
              $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Se ha actualizado correctamente la informacion --> estoy en el update de las puntuaciones --> controlador puntuaciones"  }
              format.xml { @puntuacione }
            else
              mensajesalida = Mensaje.new
              mensajesalida.salida = @puntuacione.errors
              $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo update de puntuaciones --> controlador puntuaciones"  }
              format.xml { render xml: mensajesalida }
            end
          end
        else
          mensajesalida = Mensaje.new
          mensajesalida.salida = "El usuario no puede modificar esa puntuacion"
          $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo update de puntuaciones --> controlador puntuaciones"  }
          respond_to do |format|
            format.xml { render xml: mensajesalida }
          end
        end
      end
    end
  rescue Exception=>e
    mensajesalida = Mensaje.new
    mensajesalida.salida = e.message
    $log.error("log") {"Error -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> "+ e.message+ "--> controlador puntuaciones"  }
    respond_to do |format|
      format.xml { render xml: mensajesalida }
    end
  end

  # DELETE /puntuaciones/1
  # DELETE /puntuaciones/1.xml
  def destroy
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo destroy una puntuacion, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} " }
    $log.info("log") {"Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Validando que el usuario o el comentario sean nulos --> estoy en el metodo destroy puntuacion --> controlador puntuaciones"  }
    if @user==nil or @comentario==nil
      mensajesalida = Mensaje.new
      mensajesalida.salida = "id puntuacion incorrecto"
      $log.error("log") { "Error -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Ha ocurrido un error, #{mensajesalida.salida} --> estoy en el metodo destroy puntuacion --> controlador puntuaciones"  }
      respond_to do |format|
        format.xml { render xml: mensajesalida }
      end
    else
      $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Se invoca al metodo valida_session, se le pasan los parametro: #{@user.nick_name},#{request.remote_ip} --> estoy en el metodo destroy puntuacion --> controlador puntuaciones"}
      user_control = UserController.new
      user_control.valida_session(@user,request.remote_ip)
      @puntuacione = Puntuacione.find(params[:id])
      $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Validando que el atributo puntuacione sea distinto de nul --> estoy en el metodo destroy puntuacion --> controlador puntuaciones"}
      if @puntuacione == nil
        mensajesalida = Mensaje.new
        mensajesalida.salida = "id puntuacion incorrecto"
        $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Se ha actualizado correctamente la informacion --> estoy en el destroy puntuaciones --> controlador puntuaciones"  }
        respond_to do |format|
          format.xml { render xml: mensajesalida }
        end
        #      raise Exception.new()
      else
        respond_to do |format|
          if @puntuacione.delete
            $log.info("log") {"Info -- " "Se ha eliminado correctamente, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} sus datos eran: #{@puntuacione.attributes.inspect} --> estoy en el metodo destroy --> controller puntuacion" }
            format.xml { render xml: @puntuacione }
          else
            mensajesalida = Mensaje.new
            mensajesalida.salida = "a ocurrido un error eliminando la puntuacion"            
            $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo destroy de puntuaciones --> controlador puntuaciones"  }
            format.xml { render xml: mensajesalida }
          end
        end
      end
    end
  rescue Exception=>e
    mensajesalida = Mensaje.new
    mensajesalida.salida = e.message
    $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo update de puntuaciones --> controlador puntuaciones"  }
    respond_to do |format|
      format.xml { render xml: mensajesalida }
    end
  end

end
