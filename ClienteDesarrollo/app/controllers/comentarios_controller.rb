class ComentariosController < ApplicationController
 
  before_filter :get_user

  def get_user
    @controlador_usuario=UsersController.new
    @user = @controlador_usuario.buscar_usuario_id(params[:user_id],@controlador_usuario.get_ip,@controlador_usuario.get_port)
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
     @comentarios=[]
    require 'net/http'
    require 'uri'
    require 'rexml/document'
    endpoint = Net::HTTP.new(@controlador_usuario.get_ip,@controlador_usuario.get_port)
    response = endpoint.get("/users/"+@user.id+"/comentarios")
    document = REXML::Document.new(response.body)
    xml=document.elements.to_a( "//comentarios/comentario" )

    if document[2][1].to_s.to(8) == "<comentar"
    @comentarios=[]
    contador=0
    flag = false
    while (contador < xml.size)

      comentario=Comentario.new
      comentario_id=document.elements.to_a( "//comentarios/comentario/comentario-id" )
      comentario.admite_respuesta=xml[contador][1][0]
      comentario.comentario_id=comentario_id[0][0]
      comentario.hora_publicacion=xml[contador][5][0]
      comentario.id=xml[contador][7][0]
      comentario.mensaje=xml[contador][9][0]
      #comentario.tag_ids=xml[contador][11][0]
      comentario.user_id=xml[contador][13][0]
      if comentario.mensaje.split("http://www.youtube.com/watch?v=")[1].to_s.to(10) != "0"  
        comentario.archivo=comentario.mensaje.split("http://www.youtube.com/watch?v=")[1].to_s.to(10)
    else
      comentario.archivo="<p>"
      end
      @comentarios.push(comentario)
      contador=contador+1
    end
   @user.comentarios=@comentarios
  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comentarios }
    end
    else
      @misession = Comentario.new
        xml=document.elements.to_a( "//salida" )
        @mensaje=xml[0][0]
          respond_to do |format|
        format.html  # show.html.erb
        format.json { render json: @comentarios }
      end
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
    end
  end

 
  # GET /comentarios/1/edit
  def edit
    @comentario = Comentario.find(params[:id])
  end

 # GET /comentarios/new
  # GET /comentarios/new.json 
    def new
      @mensaje="Bienvenido "+@user.nombre
    @comentario = Comentario.new
    @comentario.user_id=@user.id
    @user
    @tags=[]
        #@mensaje=document
#        respond_to do |format|
#      format.html # show.html.erb
#      format.json { render json: @comentario }
#    end
  end

  # POST /comentarios
  # POST /comentarios.json

  def create
     require 'net/http'
    http = Net::HTTP.new(@controlador_usuario.get_ip,@controlador_usuario.get_port)
    request = Net::HTTP::Post.new("/users/"+@user.id+"/comentarios.xml")
    @comentario = Comentario.new(params[:comentario])
#    if @comentario.mensaje['&nbsp;']
#      @comentario.mensaje['&nbsp;']=" "
#    end
#    if @comentario.mensaje['amp;']
#      @comentario.mensaje['amp;']=" "
#    end
#        if @comentario.mensaje['/div']
#      @comentario.mensaje['/div']=" "
#    end

    @comentario.user_id=@user.id
    @comentario=@comentario.to_xml
    request.content_type = "application/xml"
    request.body = @comentario
    response = http.request(request)
    response = Net::HTTP.start(@controlador_usuario.get_ip,@controlador_usuario.get_port) {|http| http.request(request)}


document = REXML::Document.new(response.body)
   # @mensaje= 
    
    xml=document.elements.to_a( "//salida" )
        
       if (!xml.empty?)
    if (xml[0][0]=="No hay token Vigente")

        @mensaje=xml[0][0]
        redirect_to "http://localhost:3000/sessions/"
        end
       else
               respond_to do |format|
      format.html { redirect_to user_comentarios_url }
     format.json { head :no_content }
       end
       end
#    respond_to do |format|
#      format.html { redirect_to user_comentarios_url }
#      format.json { head :no_content }
#    end
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
    #@user.comentarios.delete(@comentario)
    #@user.save
    respond_to do |format|
      format.html { redirect_to user_comentarios_url }
      format.json { head :no_content }
    end
  end

end
