class ComentariosController < ApplicationController
  
  
  before_filter :get_user

  def get_user
    @user = User.find(params[:user_id])
  end

  # GET /comentarios
  # GET /comentarios.json
  def index
    @comentarios = @user.comentarios
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comentarios }
    end
  end

  # GET /comentarios/1
  # GET /comentarios/1.json
  def show
    @comentario = @user.comentarios.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
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
    @miArreglo = []
    @miArreglo=[Comentario.new(params[:comentario])];
    @user.comentarios.push(@miArreglo)
    #@comentario = @user.comentarios
    @user.save
    #@comentario = @user.comentarios << Comentario.new(params[:comentario])
    #@comentario = @user.comentarios.new(:mensaje =>)
    respond_to do |format|
      #if @comentario.save
      format.html { redirect_to [@user, @comentario],
        notice: 'El comentario a sido creado.'} # new.html.erb

      format.json { render json: [@user, @comentario],
        status: :created,
      location: [@user, @comentario]}
#      else
#        format.html { render action: "new" }
#        format.json { render json: @comentario.errors,
#          status: :unprocessable_entity }
      #end
    end
  end

  # PUT /comentarios/1
  # PUT /comentarios/1.json
  def update
    @comentario = @user.comentarios.find(params[:id])
    respond_to do |format|
      if @comentario.update_attributes(params[:comentario])
        format.html { redirect_to [@user,@comentario], notice: 'Comentario was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comentario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comentarios/1
  # DELETE /comentarios/1.json
  def destroy
    @comentario = @user.comentarios.find(params[:id])
    @comentario.destroy
    respond_to do |format|
      format.html { redirect_to user_comentarios_url }
      format.json { head :no_content }
    end
  end
end
