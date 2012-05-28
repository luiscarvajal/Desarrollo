class TagsController < ApplicationController

  before_filter :get_user_comentario

  def get_user_comentario
    if ( (params[:user_id]) and (params[:comentario_id]) )
      @user = User.find(params[:user_id])
      @comentario = Comentario.find(params[:comentario_id])
    end
  end

  def alltag
  @tags = Tag.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tags }
      format.xml { render xml: @tags.to_xml }
    end
  end


  # GET /comentarios
  # GET /comentarios.json
  def index
    @tags = @comentario.tags
    if (@tags.size > 0)
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @tags }
      end
    else
      raise Exception.new("no se encuentran tags para ese comentario")
    end
    
  end

  # GET /comentarios/1
  # GET /comentarios/1.json
  def show
    @tag = Tag.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tag }
      format.xml { render xml: @tag }
    end
  end
  
  # GET /comentarios/new
  # GET /comentarios/new.json
  def new
    @tag = Tag.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tag }
    end
  end

  # GET /comentarios/1/edit
  def edit
    @tag = Tag.find(params[:id])
  end

  # POST /comentarios
  # POST /comentarios.json

    def create
    @tag=Tag.new(params[:tag])
    @miArreglo = []
    @tag.comentario_ids.push(@comentario.id)
    @tag.save
    @miArreglo=[@tag];
    @comentario.tags.push(@miArreglo)
    @comentario.save
    respond_to do |format|      
        format.html { redirect_to [@user,@comentario,@tag], notice: 'Puntuacione was successfully created.' }
        format.json { render json: [@user,@comentario,@tag], status: :created, location: @tag }
      
    end
    rescue Exception=>e
    @tag = Tag.new
    @tag.nombre = "Usuario o Comentario Inválido"
    respond_to do |format|
      #format.html # todos_comentarios.html.erb
      format.json { render json: @tag }
    end
  end
  
  # PUT /comentarios/1
  # PUT /comentarios/1.json
  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to @tag, notice: 'Puntuacione was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comentarios/1
  # DELETE /comentarios/1.json
  def destroy
    @tag = Tag.find(params[:id])
    @tag.delete

    respond_to do |format|
      format.html { redirect_to user_comentario_tag_url }
      format.json { head :no_content }
    end
  end

end
