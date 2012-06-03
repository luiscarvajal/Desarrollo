class SessionsController < ApplicationController
  before_filter :get_ip
  @mi_url=''
  @mi_puerto=0
  #retorna la ip del servicio web, la busca en el archivo ip.txt 
  def get_ip
    File.open('ip.txt', 'r') do |f1|
        @mi_url = f1.gets
        @mi_url=@mi_url.to(@mi_url.size-2)
      #end
    end
  end
  #Inicializa una session
  def index
    @misession = Session.new
  end
  #Envia al servicio web un xml con los datos de la session
  def create

    require 'net/http'
     require 'uri'
    require 'rexml/document'
    http = Net::HTTP.new(@mi_url,3000)
    request = Net::HTTP::Post.new("/users/login.xml")
    @misession = Session.new(params[:session])
    @misession=@misession.to_xml
    request.content_type = "application/xml"
    request.body = @misession
    response = http.request(request)
    response = Net::HTTP.start(@mi_url,3000) {|http| http.request(request)}

    document = REXML::Document.new(response.body)
#Leo el xml que responde el servidor y lo guardo en un objeto usuario

    if document[2][1].to_s.to(8) == "<apellido"
        xml=document.elements.to_a( "//user" )
        apellido=document.elements.to_a( "//apellido" )
        biografia=document.elements.to_a( "//biografia" )
        correo=document.elements.to_a( "//correo" )
        id=document.elements.to_a( "//id" )
        nick_name=document.elements.to_a( "//nick-name" )
        nombre=document.elements.to_a( "//nombre" )
        pais=document.elements.to_a( "//pais" )
        password=document.elements.to_a( "//password" )

        user=User.new

        user.apellido=apellido[0][0]
        user.biografia=biografia[0][0]
        user.correo=correo[0][0]
        user.id=id[0][0]
        user.nick_name=nick_name[0][0]
        user.nombre=nombre[0][0]
        user.pais=pais[0][0]
        user.password=password[0][0]

        @user=user

        redirect_to "http://localhost:3000/users/"+@user.id.to_s+"/comentarios/new"
        @mensaje="Bienvenido "+@user.nombre
    else
      @misession = Session.new
        xml=document.elements.to_a( "//salida" )
        @mensaje=xml[0][0]
          respond_to do |format|
        format.html  # show.html.erb
      end
    end
  end
#muestra la session activa
  def show
    @misession = Session.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @misession }
    end
  end
end
