class SessionsController < ApplicationController
  before_filter :get_ip, :get_port
  @mi_url=''
  @mi_puerto=0
  def get_ip
    File.open('ip.txt', 'r') do |f1|
      linea= f1.gets
        return @mi_url=linea.split(",")[0].to_s
    end
  end
  def get_port
        File.open('ip.txt', 'r') do |f1|
      linea= f1.gets
        @mi_puerto= linea.split(",")[1].split("\\n")[0]
      return Integer(@mi_puerto)
    end
  end
  def index
    @mensaje
    @misession = Session.new
  end
  
  def create

    require 'net/http'
     require 'uri'
    require 'rexml/document'
    http = Net::HTTP.new(get_ip,get_port)
    request = Net::HTTP::Post.new("/users/login.xml")
    session_usuario = Session.new(params[:session])
    @misession=session_usuario
    @misession=@misession.to_xml
    request.content_type = "application/xml"
    request.body =@misession
    response = http.request(request)
    response = Net::HTTP.start(get_ip,get_port) {|http| http.request(request)}
    document = REXML::Document.new(response.body)

    if (document.elements.to_a( "//mensaje/salida/" )==nil)
        user=User.new.buscar_nick_name(session_usuario.nick_name)
       @mensaje="Bienvenido "+user.nombre
       redirect_to "http://localhost:3000/users/"+@user.id.to_s+"/comentarios/new"

    elsif  document.elements.to_a( "//salida" )[0][0] == "Existe un token vigente."

        user=User.new.buscar_nick_name(session_usuario.nick_name)

       @mensaje="Bienvenido "+user.nombre
        redirect_to "http://localhost:3000/users/"+user.id.to_s+"/comentarios/new"

    else
      @misession = Session.new
        xml=document.elements.to_a( "//salida" )
        
        #@mensaje=document.elements.to_a( "//mensaje/salida/" )[0][0]
        @mensaje=params[:session]
          respond_to do |format|
        format.html  # show.html.erb
      end
    end
  end

  def show
    @misession = Session.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @misession }
    end
  end
end
