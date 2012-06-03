class TagsController < ApplicationController

  before_filter :get_user_comentario

  #!C:\Users\LILIANA\Desktop\ultimo servidor desarrollo\Desarrollo\my_app\my_app
  require 'logger'

  def log_ini
    $log=Logger.new('log.xml')
    config.log_level = :info
    config.log_level = :error
    config.log_level = :warn
  end

  def get_user_comentario
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo get_user_comentario, controlador de tags, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} "}
    $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Validando que exista el user_id y el comentario_id --> estoy en el metodo get_user_comentario --> controller tags " }
    if ( (params[:user_id]) and (params[:comentario_id]) )
      @user = User.find(params[:user_id])
      @comentario = Comentario.find(params[:comentario_id])
    $log.info("log") {"Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Los id correspondientes son #{@user} y #{@comentario} --> estoy en el metodo get_user_comentario --> controller tags "  }
     end
  end

  def alltag
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo alltag, controlador de tags, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec} "}
    @tags = Tag.all
    respond_to do |format|
      format.xml { render xml: @tags }
    end
  end

  # GET /comentarios
  # GET /comentarios.xml
  def index
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo index de los tags, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}"}
    if (@user == nil) or (@comentario == nil)
      mensajesalida = Mensaje.new
      mensajesalida.salida = "Usuario o Comentario Invalido"
      $log.warn("log") { "Warn -- " "Usuario o Comentario Invalido, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}"}
      respond_to do |format|
        format.xml { render xml: mensajesalida }
      end
    else
      $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Validando si existen tag para ese comentario --> estoy en el index --> controlador de tags" }
      @tags = @comentario.tags
      if (@tags.size > 0)
        respond_to do |format|
          format.xml { render xml: @tags }
        end
      else
        mensajesalida = Mensaje.new
        mensajesalida.salida = "no se encuentran tags para ese comentario"
        $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el index --> controlador de tags"  }
      respond_to do |format|
          format.xml { render xml: mensajesalida }
        end
      end
    end
  end

  # GET /comentarios/1
  # GET /comentarios/1.xml
  def show
    @tag = Tag.find(params[:id])
    respond_to do |format|
      format.xml { render xml: @tag }
    end
  end
  
  # GET /comentarios/new
  # GET /comentarios/new.xml
  def new
    @tag = Tag.new
    respond_to do |format|
      format.xml { render xml: @tag}
    end
  end

  # GET /comentarios/1/edit
  def edit
    @tag = Tag.find(params[:id])
  end

  # POST /comentarios
  # POST /comentarios.xml

  def create
   log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo create de los tags, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}"}
     if (@user == nil) or (@comentario == nil)
      mensajesalida = Mensaje.new
      mensajesalida.salida = "Usuario o Comentario Invalido"
      $log.warn("log") { "Warn -- " "Usuario o Comentario Invalido, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}"}
      respond_to do |format|
        format.xml { render xml: mensajesalida }
      end
    else
      @tag=Tag.new(params[:tag])
      @miArreglo = []
      @tag.comentario_ids.push(@comentario.id)
      $log.info("log") {"Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Se ha creado el tag con los siguientes valores: #{@tag.attributes.inspect}  --> estoy en el create de los tags --> controlador de tags" }
      @tag.save
      @miArreglo=[@tag];
      @comentario.tags.push(@miArreglo)
      $log.info("log") {"Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Se ha creado el cometario con los siguientes valores: #{@comentario.attributes.inspect}  --> estoy en el create de los tags --> controlador de tags" }
      @comentario.save
      respond_to do |format|
        format.xml { render xml: [@user,@comentario,@tag], status: :created}
      end
    end
  end
  
  # PUT /comentarios/1
  # PUT /comentarios/1.xml
  def update
    if (@user == nil) or (@comentario == nil)
      mensajesalida = Mensaje.new
      mensajesalida.salida = "Usuario o Comentario Invalido"
      $log.warn("log") { "Warn -- " "Usuario o Comentario Invalido, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}"}
      respond_to do |format|
        format.xml { render xml: mensajesalida }
      end
    else
     log_ini
     $log.info("log") { "Info -- " "Entrando en el metodo update de los tags, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}"}
     @tag = Tag.find(params[:id])
      respond_to do |format|
        if @tag.update_attributes(params[:tag])
          $log.info("log") { "Info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. Se ha actualizado correctamente el tag --> estoy en el update de los tags --> controlador tags"  }
          format.xml { @tag }
        else
          mensajesalida = Mensaje.new
          mensajesalida.salida = @tag.errors
          respond_to do |format|
            $log.warn("log") {"Warn -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el metodo update de los tagas --> controlador de tags"  }
            format.xml { render xml: mensajesalida }
          end
          #        format.html { render action: "edit" }
          #        format.json { render json: @tag.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /comentarios/1
  # DELETE /comentarios/1.xml
  def destroy
    log_ini
    $log.info("log") { "Info -- " "Entrando en el metodo update de los tags, el dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}"}
    @tag = Tag.find(params[:id])   

    respond_to do |format|
      if (@tag.delete)
        mensajesalida = Mensaje.new
        mensajesalida.salida = "El tag se ha eliminado con exito"
        $log.info("log") {"info -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el destroy de los tagas --> controlador de tags"  }
        respond_to do |format|
          format.xml { render xml: mensajesalida }
        end
      else
        mensajesalida = Mensaje.new
        mensajesalida.salida = "El tag se ha eliminado con exito"
        $log.Error("log") {"Error -- " "Dia #{Time.new.day}/#{Time.new.mon}/#{Time.new.year} a las #{Time.new.hour}:#{Time.new.min}:#{Time.new.sec}. #{mensajesalida.salida} --> estoy en el destroy de los tagas --> controlador de tags"  }
        respond_to do |format|
          format.xml { render xml: mensajesalida }
        end
      end
      
    end
  end  
end
