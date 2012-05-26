class ComentariosController < ApplicationController
 require "exceptions.rb"
# require "users_controller.rb"
  before_filter :get_user

  def get_user
    @user = User.find(params[:user_id])
    if (@user == nil)
      raise Exception.new("Usuario Incorrecto")
    end
  end
# GET /comentarios
  # GET /comentarios.json
  def view
  @users= User.all
  @comentarios = Comentario.all
    respond_to do |format|
      format.html # todos_comentarios.html.erb
      format.json { render json: @comentarios }
    end
  rescue Exception=>e
    @comentario = Comentario.new
    @comentario.mensaje = "Usuario Inválido"
    respond_to do |format|
      format.html # todos_comentarios.html.erb
      format.json { render json: @comentario }
    end
  end

  def tagfilter
    #@users= User.all
    #@comentarios = Comentario.all
    @tags = (params[:tags])
    respond_to do |format|
      format.json { render json: @tags }
      format.xml { render xml: @tags }
    end
  end
  # GET /comentarios
  # GET /comentarios.json
  def index
    @comentarios = @user.comentarios
    if (@comentarios.size > 0)
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @comentarios }
        format.xml { render xml: @comentarios }
      end
    else
      @comentario = Comentario.new
      @comentario.mensaje = "No existen comentarios"
      respond_to do |format|
        format.html # todos_comentarios.html.erb
        format.json { render json: @comentario }
      end
    end
    rescue Exception=>e
    @comentario = Comentario.new
    @comentario.mensaje = "Usuario Inválido"
    respond_to do |format|
      format.html # todos_comentarios.html.erb
      format.json { render json: @comentario }
    end
  end

  # GET /comentarios/1
  # GET /comentarios/1.json
  def show
    if (params[:id]=="view")
      @users= User.all
      @comentarios = Comentario.all
      respond_to do |format|
        format.html # todos_comentarios.html.erb
        format.json { render json: @comentarios }
        format.xml { render xml: @comentario }
      end
    end

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
    @comentario.save
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comentario }
      format.xml { render xml: @comentario }
    end
    rescue Exception=>e
    @comentario = Comentario.new
    @comentario.mensaje = "Usuario o Comentario Inválido"
    respond_to do |format|
      format.html # todos_comentarios.html.erb
      format.json { render json: @comentario }
    end
  end

  # GET /comentarios/new
  # GET /comentarios/new.json
  def new
    @comentario = Comentario.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comentario }
    end
  end

  # GET /comentarios/1/edit
  def edit
    @comentario = Comentario.find(params[:id])
  end

  # POST /comentarios
  # POST /comentarios.json  
  def create
    valida_session(@user, request.remote_ip)
    @miArreglo = []
    @comentario = Comentario.new(params[:comentario])
    @comentario.hora_publicacion = Time.new.to_s
    @miArreglo=[@comentario];
    @user.comentarios.push(@miArreglo)
    @user.save
    
    respond_to do |format|
      #if @comentario.save
      format.html { redirect_to [@user, @comentario],
        notice: 'El comentario a sido creado.'} # new.html.erb

      format.json { render json: @comentario}
      format.xml { render xml: @comentario}

    end
  rescue Exceptions::BusinessException => be
    raise Exceptions::BusinessException.new(be.message)
  rescue Exception => e
    raise Exceptions::BusinessException.new(e.message)
  end

  # PUT /comentarios/1
  # PUT /comentarios/1.json
  def update
    valida_session(@user, request.remote_ip)
    @comentario = @user.comentarios.find(params[:id])
    @arrayComentario = @user.comentarios
    respond_to do |format|
      if @comentario.update_attributes(params[:comentario])
        #format.html { redirect_to [@user,@comentario], notice: 'Comentario was successfully updated.' }
        format.json { render json: @comentario }
        format.xml { render xml: @comentario }
      else
        raise Exceptions::BusinessException @comentario.errors
      end
    end
  rescue Exceptions::BusinessException => be
    raise Exceptions::BusinessException.new(be.message)
  rescue Exception=>e
    raise Exception.new("id_usuario o id_comentario Inválido")
  end

  # DELETE /comentarios/1
  # DELETE /comentarios/1.json
  def destroy
    valida_session(@user, request.remote_ip)
    @comentario = @user.comentarios.find(params[:id])
    @comentario.destroy
    @comentariout = Comentario.new
    @comentariout.mensaje = "Comentario Eliminado con exito"
    #@user.comentarios.delete(@comentario)
    #@user.save
    respond_to do |format|
      #format.html { redirect_to user_comentarios_url }
      format.json { render json: @comentariout}
      format.xml { render xml: @comentariout}
    end
  rescue Exceptions::BusinessException => be
    raise Exceptions::BusinessException.new(be.message)
  rescue Exception=>e
    raise Exception.new("Usuario o Comentario Inválido")
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
  rescue Exception=>e
    raise Exceptions::BusinessException.new("No hay token Vigente")
  end

end
