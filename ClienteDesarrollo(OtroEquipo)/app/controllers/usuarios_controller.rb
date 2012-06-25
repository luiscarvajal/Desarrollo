class UsuariosController < ApplicationController
  before_filter :get_ip
  @mi_url=''
  @mi_puerto=0
  #buscar en el archivo ip.txt la ip del servidor de servicios web
  def get_ip
    File.open('ip.txt', 'r') do |f1|
        @mi_url = f1.gets
        @mi_url=@mi_url.to(@mi_url.size-2)
      #end
    end
  end
  # GET /users
  # Solicital al servidor un xml con todos los usuarios del sistema
  #   los guarda en un arreglo de usuarios y luego los muestra en la interfaz

  def index
   @users = session[:token]   
      respond_to do |format|
        format.html
        format.xml { render xml: @users}
      end

      #      raise Exceptions::BusinessException.new("No existen usuarios")
    


#    require 'net/http'
#    require 'uri'
#    require 'rexml/document'
#    endpoint = Net::HTTP.new(@mi_url,3000)
#    response = endpoint.get("/users.xml")
#    document = REXML::Document.new(response.body)
#    xml=document.elements.to_a( "//users/user" )
#
#    @users=[]
#    contador=0
#
#    while (contador < xml.size)
#
#      user=User.new
#
#      user.apellido=xml[contador][1][0]
#      user.biografia=xml[contador][3][0]
#      user.correo=xml[contador][5][0]
#      user.foto=xml[contador][7][0]
#      user.id=xml[contador][9][0]
#      user.nick_name=xml[contador][11][0]
#      user.nombre=xml[contador][13][0]
#      user.pais=xml[contador][15][0]
#      user.password=xml[contador][17][0]
#
#      @users.push(user)
#      contador=contador+1
#
#    end
#
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml { render xml: xml }
#    end
    
  end

  # GET /users/1
  # GET /users/1.json
  #  Solicita al servidor todos los usuarios y luego compara por el id que esta recibiendo por url si son iguales devuelve un usuario
  # sino devuelve un usuario vacio
  def show
    
    require 'net/http'
    require 'uri'
    require 'rexml/document'
    endpoint = Net::HTTP.new(@mi_url,3000)
    response = endpoint.get("/users.xml")
    document = REXML::Document.new(response.body)
    xml=document.elements.to_a( "//users/user" )

    @users=[]
    contador=0
    flag = false
    while (contador < xml.size)

      user=Usuario.new

      user.apellido=xml[contador][1][0]
      user.biografia=xml[contador][3][0]
      user.correo=xml[contador][5][0]
      user.foto=xml[contador][7][0]
      user.id=xml[contador][9][0]
      user.nick_name=xml[contador][11][0]
      user.nombre=xml[contador][13][0]
      user.pais=xml[contador][15][0]
      user.password=xml[contador][17][0]
      if (user.id.to_s==params[:id].to_s)
        @user=user
        flag = true
        break
      end
      contador=contador+1

    end
    if flag == false
      @user=Usuario.new
    end
@mensaje=flag
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new

    @user = Usuario.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

#busca un usuario dado un id de usuarui y la ip del servidor
  def buscar_usuario_id(id,url)

    require 'net/http'
    require 'uri'
    require 'rexml/document'
    endpoint = Net::HTTP.new(url,3000)
    response = endpoint.get("/users.xml")
    document = REXML::Document.new(response.body)
    xml=document.elements.to_a( "//users/user" )

    @users=[]
    contador=0
    flag = false
    while (contador < xml.size)

      user=Usuario.new
      user.apellido=xml[contador][1][0]
      user.biografia=xml[contador][3][0]
      user.correo=xml[contador][5][0]
      user.foto=xml[contador][7][0]
      user.id=xml[contador][9][0]
      user.nick_name=xml[contador][11][0]
      user.nombre=xml[contador][13][0]
      user.pais=xml[contador][15][0]
      user.password=xml[contador][17][0]
      if (user.id.to_s==id.to_s)
        return user
      end
      contador=contador+1

    end
    if flag == false
      user=Usuario.new
      return user
    end

  end
  # Recive id por url y responde a la vista un usaurio para ser editado
  # GET /users/1/edit
  def edit
    @user = buscar_usuario_id(params[:id],get_ip)
  end

  # POST /users
  # POST /users.json
  #envia al servidor un xml con los datos del usuario a ser creado
  def create    
    require 'net/http'
    require 'rexml/document'    
    http = Net::HTTP.new(@mi_url,80)
#    request = Net::HTTP::Post.new("/Ultimo/Desarroll/usuarios/Registrarse")
     request = Net::HTTP::Post.new("/users.xml")
     @user = Usuario.new(params[:Usuario])
     @user=@user.to_xml
     request.content_type = "application/xml"
     @user['usuario']="Usuario"
     @user['/usuario']="/Usuario"
     request.body = @user
     response = http.request(request)
     response = Net::HTTP.start(@mi_url,80) {|http| http.request(request)}
     document = REXML::Document.new(response.body)
     xml=document.elements.to_a( "//Exito" )
     @texto = xml[0][0].to_s
     if @texto.eql?("Operacion exitosa")
       redirect_to "/sessions"
#        flash[:notice] = "Usuario Creado"
#        redirect_to ""   usuarios_url
     else
      raise Exception.new("Error desde el servicio")
     end    
  rescue Exception=>e
    xml = []
    xml=document.elements.to_a( "//Error" )
    if xml.empty?
      @texto = 'Error en el servicio (crear Usuario)'
    else
      @texto = xml[0].to_s
    end
    respond_to do |format|
         format.html { redirect_to [@mensaje], notice: @texto }
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  #envia al servidor un xml con los datos del usuario a ser actualizado
  def update
    require 'net/http'
    require 'rexml/document'
    http = Net::HTTP.new(@mi_url,80)
#    request = Net::HTTP::Post.new("/Desarroll/usuarios/actualizar/"+@token.mensaje)
     request = Net::HTTP::Post.new("/users.xml")
     @user = Usuario.new(params[:Usuario])
     @user=@user.to_xml
     request.content_type = "application/xml"
     @user['usuario']="Usuario"
     @user['/usuario']="/Usuario"
     request.body = @user
     response = http.request(request)
     response = Net::HTTP.start(@mi_url,80) {|http| http.request(request)}
     document = REXML::Document.new(response.body)
     xml=document.elements.to_a( "//Exito" )
     @texto = xml[0][0].to_s
     if @texto.eql?("Operacion exitosa")
       redirect_to "/sessions"
#        flash[:notice] = "Usuario Creado"
#        redirect_to ""   usuarios_url
     else
      raise Exception.new("Error desde el servicio")
     end
  rescue Exception=>e
    xml = []
    xml=document.elements.to_a( "//Error" )
    if xml.empty?
      @texto = 'Error en el servicio (modificar Usuario)'
    else
      @texto = xml[0].to_s
    end
    respond_to do |format|
         format.html { redirect_to [@mensaje], notice: @texto }
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  #envia al servidor un xml con los datos del usuario a ser destruido 
  def destroy

    @user = buscar_usuario_id(params[:id],get_ip)

    require 'net/http'
    http = Net::HTTP.new(@mi_url,3000)
    request = Net::HTTP::Delete.new("/users/"+params[:id])
    @user=@user.to_xml
    request.content_type = "application/xml"
    request.body = @user
    response = http.request(request)
    response = Net::HTTP.start(@mi_url,3000) {|http| http.request(request)}
    document= REXML::Document.new(response.body)
    xml=document.elements.to_a( "//salida" )
    
    @mensaje=@user
    respond_to do |format|
      format.html { redirect_to users_url }
      format.html # index.html.erb
#      format.json { head :no_content }
    end
  end
end
