class PuntuacionesController < ApplicationController


  before_filter :get_user_comentario

  def get_user_comentario
    @user = User.find(params[:user_id])
    @comentario = Comentario.find(params[:comentario_id])
  end

  def lista_puntuaciones
    @puntuaciones = Puntuacione.all
    if (@puntuaciones.size > 0)
      respond_to do |format|        
        format.json { render json: @puntuaciones }
        format.xml  { render xml: @puntuaciones }
      end
    else
      @puntuaciones = Puntuacione.new
      @puntuaciones.mensaje = "No existen Puntuaciones"
      respond_to do |format|        
        format.json { render json: @puntuaciones }
        format.xml  { render xml: @puntuaciones }
      end
    end

  rescue Exception=>e
    @puntuaciones = Puntuacione.new
    @puntuaciones.mensaje = "A ocurrido un error"
  end

  # GET /puntuaciones
  # GET /puntuaciones.json
  def index
#    @puntuaciones = Puntuacione.all
    @puntuaciones = Puntuacione.where(:comentario_id => @comentario.id)

    if (@puntuaciones.size > 0)
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @puntuaciones }
        format.xml  { render xml: @puntuaciones }
      end
    else
      @puntuaciones = Puntuacione.new
      @puntuaciones.mensaje = "No existen Puntuaciones"
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @puntuaciones }
        format.xml  { render xml: @puntuaciones }
      end
    end
    
  rescue Exception=>e
    @puntuaciones = Puntuacione.new
    @puntuaciones.mensaje = "A ocurrido un error"
  end

  # GET /puntuaciones/1
  # GET /puntuaciones/1.json
  def show

    @puntuacione = Puntuacione.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @puntuacione }
      format.xml { render xml: @puntuacione }
    end
  end

  # GET /puntuaciones/new
  # GET /puntuaciones/new.json
  def new
    
    @puntuacione = Puntuacione.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @puntuacione }
      format.xml { render xml: @puntuacione}
    end
  end

  # GET /puntuaciones/1/edit
  def edit
    @puntuacione = Puntuacione.find(params[:id])
  end

  # POST /puntuaciones
  # POST /puntuaciones.json
  def create    
    @user
    @comentario
    valida_session(@user,request.remote_ip)
    @puntuacione = Puntuacione.new(params[:puntuacione])
    if (@puntuacione.me_gusta != nil) and (@puntuacione.no_me_gusta != nil)
      raise Exception.new("No se puede tener mas de un puntaje")
    end

      aux=Puntuacione.all
      flag=false
      for mipuntuacion in aux
        if mipuntuacion.user_id == @user.id and mipuntuacion.comentario_id==@comentario.id
          flag=true
        end
      end
      if flag == true
        raise Exception.new("El usuario ya puntuo ese comentario")
      end

        @puntuacione.comentario_id=@comentario.id
        @puntuacione.user_id=@user.id
        respond_to do |format|
          if @puntuacione.save
            @puntuacione.mensaje = "El comentario fue Puntuado Con exito"
            format.html { redirect_to [@user,@comentario,@puntuacione], notice: 'Puntuacione was successfully created.' }
            format.json { render json: @puntuacione}
            format.xml { render xml: @puntuacione}
          else
            raise Exception.new([@user,@comentario,@puntuacione].errors)
          end
        end
  end
  # PUT /puntuaciones/1
  # PUT /puntuaciones/1.json
  def update
    @puntuacione = Puntuacione.find(params[:id])

    respond_to do |format|
      if @puntuacione.update_attributes(params[:puntuacione])
        format.html { redirect_to @puntuacione, notice: 'Puntuacione was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @puntuacione.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /puntuaciones/1
  # DELETE /puntuaciones/1.json
  def destroy
    valida_session(@user,request.remote_ip)
    @puntuacione = Puntuacione.find(params[:id])
    if @puntuacione == nil
      raise Exception.new("id puntuacion incorrecto")
    end
    respond_to do |format|
      if @puntuacione.delete
        #format.html { redirect_to user_comentario_puntuaciones_url }
        format.json { render json: @puntuacione }
        format.json { render json: @puntuacione }
      else
        raise Exception.new("a ocurrido un error eliminando la puntuacion")
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
