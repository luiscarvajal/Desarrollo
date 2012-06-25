class PuntuacionesController < ApplicationController


 before_filter :get_user_comentario

  def get_user_comentario
    @user = User.find(params[:user_id])
    @comentario = Comentario.find(params[:comentario_id])
  end


  # GET /puntuaciones
  # GET /puntuaciones.json
  def index
    @puntuaciones = Puntuacione.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @puntuaciones }
    end
  end

  # GET /puntuaciones/1
  # GET /puntuaciones/1.json
  def show

    @puntuacione = Puntuacione.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @puntuacione }
    end
  end

  # GET /puntuaciones/new
  # GET /puntuaciones/new.json
  def new
    
    @puntuacione = Puntuacione.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @puntuacione }
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
    @puntuacione = Puntuacione.new(params[:puntuacione])
    aux=Puntuacione.all
    flag=false
    for mipuntuacion in aux
      if mipuntuacion.user_id == @user.id and mipuntuacion.comentario_id==@comentario.id
          flag=true
      end
    end
    if flag == false
      @puntuacione.comentario_id=@comentario.id
      @puntuacione.user_id=@user.id
      respond_to do |format|
        if @puntuacione.save
          format.html { redirect_to [@user,@comentario,@puntuacione], notice: 'Puntuacione was successfully created.' }
          format.json { render json: [@user,@comentario,@puntuacione], status: :created, location: @puntuacione }
        else
          format.html { render action: "new" }
          format.json { render json: [@user,@comentario,@puntuacione].errors, status: :unprocessable_entity }
        end
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
    @puntuacione = Puntuacione.find(params[:id])
    @puntuacione.delete

    respond_to do |format|
      format.html { redirect_to user_comentario_puntuaciones_url }
      format.json { head :no_content }
    end
  end
end
