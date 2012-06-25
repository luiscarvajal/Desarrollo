class MensajesController < ApplicationController
 
  before_filter :get_ip
  @mi_url=''
  @mi_puerto=0
  #buscar en el archivo ip.txt la ip del servidor de servicios web
  def get_ip
    File.open('ip.txt', 'r') do |f1|
        @mi_url = f1.gets
        @mi_url=@mi_url.to(@mi_url.size-2)
      #end
        @token = Token.last
    end
  end
  # GET /mensajes
  # GET /mensajes.json
  #muestra todos los mensajes del sistema
  def view
    @nick = ''
    @tag = ''
    require 'net/http'
    require 'uri'
    require 'rexml/document'
    endpoint = Net::HTTP.new(@mi_url,80)
    response = endpoint.get("/users.xml")
#    response = endpoint.get("/Ultimo/Desarroll/mensajes/show_all")
    document = REXML::Document.new(response.body)
    xml=document.elements.to_a( "//mensajes/mensaje" )

    @mensajes=[]
    contador=0
    flag = false    
    while (contador < xml.size)
      contador3 = 0
      mensaje = Mensaje.new
      mensaje.id = xml[contador][1][0].to_s
      mensaje.fechacreacion = xml[contador][3][0].to_s
      contador2 = 1
      usuariosmegusta = xml[contador][5]
      mensaje.usuariosmegusta = []
      while (contador2 < usuariosmegusta.size)
        mensaje.usuariosmegusta.push(usuariosmegusta[contador2][0].to_s)
        contador2 = contador2 + 2
        contador3 = contador3 + 1
      end
      mensaje.me_gusta = contador3
      usuariosnomegusta = xml[contador][7]
      contador2 = 1
      contador3 = 0
      mensaje.usuariosnomegusta = []
      while (contador2 < usuariosnomegusta.size)
        mensaje.usuariosnomegusta.push(usuariosnomegusta[contador2][0].to_s)
        contador2 = contador2 + 2
        contador3 = contador3 + 1
      end
      mensaje.no_me_gusta = contador3
      contador2 = 1
      adjuntos = xml[contador][9]
      mensaje.adjuntos = []
      while (contador2 < adjuntos.size)
        mensaje.adjuntos.push(adjuntos[contador2][0].to_s)
        contador2 = contador2 + 2
      end
      mensaje.comentario = xml[contador][11][0].to_s
      if mensaje.comentario.split("http://www.youtube.com/watch?v=")[1].to_s.to(10) != "0"
        mensaje.video = mensaje.comentario.split("http://www.youtube.com/watch?v=")[1].to_s.to(10)
      end
      @mensajes.push(mensaje)
      contador = contador + 1
    end
    respond_to do |format|
      format.html # index.html.erb
#
    end
  end

  def tagfilter
    #@users= User.all
    #@mensajes = Mensaje.all
    @tags = (params[:tags])
    respond_to do |format|
      format.json { render json: @tags }
      format.xml { render xml: @tags }
    end
  end

 
  # GET /mensajes
  # GET /mensajes.json
  #muestra todos los mensajes de un usuario dado
  def index
    require 'net/http'
    require 'uri'
    require 'rexml/document'
    endpoint = Net::HTTP.new(@mi_url,80)
    response = endpoint.get("/users.xml")
#    response = endpoint.get("/Ultimo/Desarroll/mensajes/busquedaporusuario/"+@token.nick)
    document = REXML::Document.new(response.body)
    xml=document.elements.to_a( "//mensajes/mensaje" )
    @mensajes=[]
    contador=0
    flag = false
    while (contador < xml.size)
      mensaje = Mensaje.new
      contador3 = 0
      mensaje.id = xml[contador][1][0].to_s
      mensaje.fechacreacion = xml[contador][3][0].to_s
      contador2 = 1
      usuariosmegusta = xml[contador][5]
      mensaje.usuariosmegusta = []
      while (contador2 < usuariosmegusta.size)
        mensaje.usuariosmegusta.push(usuariosmegusta[contador2][0].to_s)
        contador2 = contador2 + 2
        contador3 = contador3 + 1
      end
      mensaje.me_gusta = contador3
      usuariosnomegusta = xml[contador][7]
      contador2 = 1
      contador3 = 0
      mensaje.usuariosnomegusta = []
      while (contador2 < usuariosnomegusta.size)
        mensaje.usuariosnomegusta.push(usuariosnomegusta[contador2][0].to_s)
        contador2 = contador2 + 2
        contador3 = contador3 + 1
      end
      contador2 = 1
      mensaje.no_me_gusta = contador3
      adjuntos = xml[contador][9]      
      mensaje.adjuntos = []
      while (contador2 < adjuntos.size)
        mensaje.adjuntos.push(adjuntos[contador2][0].to_s)
        contador2 = contador2 + 2
      end    
      mensaje.comentario = xml[contador][11][0].to_s
      if mensaje.comentario.split("http://www.youtube.com/watch?v=")[1].to_s.to(10) != "0"
        mensaje.video = mensaje.comentario.split("http://www.youtube.com/watch?v=")[1].to_s.to(10)
      end
      @mensajes.push(mensaje)
      contador = contador + 1
    end

    respond_to do |format|      
      format.html # index.html.erb
      format.json {render json: @mensajes}
    end
  end

  # GET /mensajes/1
  # GET /mensajes/1.json
  #muestra un mensaje en particular de un usuario
  def show

#    @mensaje = @user.mensajes.find(params[:id])
    require 'net/http'
    require 'uri'
    require 'rexml/document'
    endpoint = Net::HTTP.new(@mi_url,80)
    response = endpoint.get("/users.xml")
#    response = endpoint.get("/Ultimo/Desarroll/mensajes/busquedaporid/"+params[:id])
    document = REXML::Document.new(response.body)
    xml=document.elements.to_a( "//mensajes/mensaje" )
  
    contador=0
    contador3 = 0
    mensaje = Mensaje.new
    mensaje.id = xml[contador][1][0].to_s
    mensaje.fechacreacion = xml[contador][3][0].to_s
    contador2 = 1
    usuariosmegusta = xml[contador][5]
    mensaje.usuariosmegusta = []
    while (contador2 < usuariosmegusta.size)
      mensaje.usuariosmegusta.push(usuariosmegusta[contador2][0].to_s)
      contador2 = contador2 + 2
      contador3 = contador3 + 1
    end
    mensaje.me_gusta = contador3
    contador3 = 0
    usuariosnomegusta = xml[contador][7]
    contador2 = 1
    mensaje.usuariosnomegusta = []
    while (contador2 < usuariosnomegusta.size)
      mensaje.usuariosnomegusta.push(usuariosnomegusta[contador2][0].to_s)
      contador2 = contador2 + 2
      contador3 = contador3 + 1
    end
    mensaje.no_me_gusta = contador3
    contador2 = 1
    adjuntos = xml[contador][9]
    mensaje.adjuntos = []
    while (contador2 < adjuntos.size)
      mensaje.adjuntos.push(adjuntos[contador2][0].to_s)
      contador2 = contador2 + 2
    end
    mensaje.comentario = xml[contador][11][0].to_s
    if mensaje.comentario.split("http://www.youtube.com/watch?v=")[1].to_s.to(10) != "0"
        mensaje.video = mensaje.comentario.split("http://www.youtube.com/watch?v=")[1].to_s.to(10)
    end
    @mensaje = mensaje
    
    endpoint = Net::HTTP.new(@mi_url,80)
    response = endpoint.get("/users/respuesta.xml")
#    response = endpoint.get("/Ultimo/Desarroll/respuestas/VerRespuestas/"+@respuesta.id)
    document = REXML::Document.new(response.body)
    xml=document.elements.to_a( "//respuestas/respuesta" )
    @respuestas=[]
    contador=0
    flag = false
    while (contador < xml.size)
      respuesta = Mensaje.new
      contador3 = 0
      respuesta.id = xml[contador][1][0].to_s
      respuesta.comentario = xml[contador][3][0].to_s
      if respuesta.comentario.split("http://www.youtube.com/watch?v=")[1].to_s.to(10) != "0"
        respuesta.video = respuesta.comentario.split("http://www.youtube.com/watch?v=")[1].to_s.to(10)
      end
      respuesta.nick_name = xml[contador][5][0].to_s
      respuesta.me_gusta = xml[contador][7].to_s
      respuesta.no_me_gusta = xml[contador][9].to_s
      respuesta.fechacreacion = xml[contador][11][0].to_s      
      @respuestas.push(respuesta)
      contador = contador + 1
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json {render json: document.to_s}
    end
  end

  def puntuar
    puntuacion = Mensaje.new(params[:mensaje])
    mensid = params[:id]
    if (puntuacion.me_gusta == 1)and(puntuacion.no_me_gusta==0)
      puntuar_me_gusta(mensid)
    elsif (puntuacion.no_me_gusta == 1) and (puntuacion.me_gusta == 0)
      puntuar_no_me_gusta(mensid)
    else
      @texto = 'Error en el servicio (enviarComentario)'
      respond_to do |format|
         format.html { redirect_to [puntuacion], notice: @texto }
      end
    end
#    respond_to do |format|
##      format.json {render json: mensid}
#      format.xml {render xml: me_gusta.to_s}
#    end
  end

  def puntuar_me_gusta (id_mensaje)
    require 'net/http'
    require 'uri'
    require 'rexml/document'
    endpoint = Net::HTTP.new(@mi_url,80)
    response = endpoint.get("/users/pruebaserv.xml")
#    response = endpoint.get("/Ultimo/Desarroll/mensajes/like/"+id_mensaje+"/"+@token.nick+"/"+@token.mensaje)
    document = REXML::Document.new(response.body)
    xml=document.elements.to_a( "//Exito" )
    @texto=xml[0].to_s.to(6).to_s
    if @texto.eql?("<Exito>")     
      redirect_to "/mensajes"
    else
      raise Exception.new("Error desde el servicio")
    end
  rescue Exception=>e
    xml = []
    xml=document.elements.to_a( "//Error" )
    if xml.empty?
      @texto = 'Error en el servicio (enviarComentario)'
    else
      @texto = xml[0].to_s
    end
    respond_to do |format|
         format.html { redirect_to [@mensaje], notice: @texto }
    end
  end

  def puntuar_no_me_gusta (id_mensaje)
    require 'net/http'
    require 'uri'
    require 'rexml/document'
    endpoint = Net::HTTP.new(@mi_url,80)
    response = endpoint.get("/users/pruebaserv.xml")
#    response = endpoint.get("/Ultimo/Desarroll/mensajes/dislike/"+id_mensaje+"/"+@token.nick+"/"+@token.mensaje)
    document = REXML::Document.new(response.body)
    xml=document.elements.to_a( "//Exito" )
    @texto=xml[0].to_s.to(6).to_s
    if @texto.eql?("<Exito>")
      @texto = 'El mensaje'+id_mensaje+'fue puntuado con exito'
      respond_to do |format|
         format.html { redirect_to [@mensaje], notice: @texto }
      end
#      redirect_to "/mensajes"
    else
      raise Exception.new("Error desde el servicio")
    end
  rescue Exception=>e
    xml = []
    xml=document.elements.to_a( "//Error" )
    if xml.empty?
      @texto = 'Error en el servicio (enviarComentario)'
    else
      @texto = xml[0].to_s
    end
    respond_to do |format|
         format.html { redirect_to [@mensaje], notice: @texto }
    end
  end

  def busquedaxnick
    require 'net/http'
    require 'uri'
    require 'rexml/document'
    @nick = params[:nick]
    endpoint = Net::HTTP.new(@mi_url,80)
    response = endpoint.get("/users.xml")
#    response = endpoint.get("/Ultimo/Desarroll/mensajes/busquedaporusuario/"+@nick)
    document = REXML::Document.new(response.body)
    xml=document.elements.to_a( "//mensajes/mensaje" )

    @mensajes=[]
    contador=0
    flag = false
    while (contador < xml.size)
      mensaje = Mensaje.new
      mensaje.id = xml[contador][1][0].to_s
      mensaje.fechacreacion = xml[contador][3][0].to_s
      contador2 = 1
      usuariosmegusta = xml[contador][5]
      mensaje.usuariosmegusta = []
      while (contador2 < usuariosmegusta.size)
        mensaje.usuariosmegusta.push(usuariosmegusta[contador2][0].to_s)
        contador2 = contador2 + 2
      end
      usuariosnomegusta = xml[contador][7]
      contador2 = 1
      mensaje.usuariosnomegusta = []
      while (contador2 < usuariosnomegusta.size)
        mensaje.usuariosnomegusta.push(usuariosnomegusta[contador2][0].to_s)
        contador2 = contador2 + 2
      end
      contador2 = 1
      adjuntos = xml[contador][9]
      mensaje.adjuntos = []
      while (contador2 < adjuntos.size)
        mensaje.adjuntos.push(adjuntos[contador2][0].to_s)
        contador2 = contador2 + 2
      end
      mensaje.comentario = xml[contador][11][0].to_s
      @mensajes.push(mensaje)
      contador = contador + 1
    end

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def busquedaxtag
    require 'net/http'
    require 'uri'
    require 'rexml/document'
    @tag = params[:tag]
    http = Net::HTTP.new(@mi_url,80)
#    request = Net::HTTP::Post.new("/Ultimo/Desarroll/mensajes/enviarComentario/"+@token.mensaje)
    request = Net::HTTP::Post.new("/servs.xml")
    request.content_type = "application/xml"
    request.body = '<?xml version="1.0" encoding="UTF-8"?><Mensaje>
<tags><tag>'+@tag+'</tag></tags></Mensaje>'
    response = http.request(request)
    response = Net::HTTP.start(@mi_url,80) {|http| http.request(request)}
    document = REXML::Document.new(response.body)
    xml=document.elements.to_a( "//mensajes/mensaje" )

    @mensajes=[]
    contador=0
    flag = false
    while (contador < xml.size)
      mensaje = Mensaje.new
      mensaje.id = xml[contador][1][0].to_s
      mensaje.fechacreacion = xml[contador][3][0].to_s
      contador2 = 1
      usuariosmegusta = xml[contador][5]
      mensaje.usuariosmegusta = []
      while (contador2 < usuariosmegusta.size)
        mensaje.usuariosmegusta.push(usuariosmegusta[contador2][0].to_s)
        contador2 = contador2 + 2
      end
      usuariosnomegusta = xml[contador][7]
      contador2 = 1
      mensaje.usuariosnomegusta = []
      while (contador2 < usuariosnomegusta.size)
        mensaje.usuariosnomegusta.push(usuariosnomegusta[contador2][0].to_s)
        contador2 = contador2 + 2
      end
      contador2 = 1
      adjuntos = xml[contador][9]
      mensaje.adjuntos = []
      while (contador2 < adjuntos.size)
        mensaje.adjuntos.push(adjuntos[contador2][0].to_s)
        contador2 = contador2 + 2
      end
      mensaje.comentario = xml[contador][11][0].to_s
      @mensajes.push(mensaje)
      contador = contador + 1
    end

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  # GET /mensajes/1/edit
  def edit
    @mensaje = Mensaje.find(params[:id])
  end

 # GET /mensajes/new
  # GET /mensajes/new.json

  def new
     require 'net/http'
    require 'uri'
    require 'rexml/document'
    @mensaje = Mensaje.new   
    endpoint = Net::HTTP.new(@mi_url,80)
    response = endpoint.get("/servs.xml")
#    response = endpoint.get("/ultimo/Desarroll/tags/tagspopulares")
    document = REXML::Document.new(response.body)
    xml=document.elements.to_a( "//Tags/tag" )
    
    @tags=[]
    contador=0

    while (contador < xml.size)

      tag = Tag.new
      tag.nombre=xml[contador][1][0]
      tag.cantidad=xml[contador][3][0]
      @tags.push(tag)
      contador=contador+1
    end
    respond_to do |format|
      format.html # show.html.erb
 
    end
  end

  # POST /mensajes
  # POST /mensajes.json
# Envia al servicio web un xml con los datos del mensaje para ser guardado
  def create
    require 'net/http'
    http = Net::HTTP.new(@mi_url,80)    
#    request = Net::HTTP::Post.new("/Ultimo/Desarroll/mensajes/enviarComentario/"+@token.mensaje)
    request = Net::HTTP::Post.new("/servs.xml")
    request.content_type = "application/xml"
    @mensaje = Mensaje.new (params[:Mensaje])
    lista_tags = @mensaje.tags
    lista_salida = ''
    for tag in lista_tags
      lista_salida = lista_salida+'<tags>'+tag.to_s+'</tags>'
    end

    request.body = '<?xml version="1.0" encoding="UTF-8"?>
    <Mensaje>
<nombre>'+@mensaje.nombre.to_s+'</nombre>
<comentario>'+@mensaje.comentario.to_s+'</comentario>
<respuesta>'+@mensaje.respuesta.to_s+'</respuesta>
<notificacion>'+@mensaje.notificacion.to_s+'</notificacion>
<adjunto></adjunto>
<usuario>'+@mensaje.usuario.to_s+'</usuario>
'+lista_salida+'
</Mensaje>'
    
    response = http.request(request)
    response = Net::HTTP.start(@mi_url,80) {|http| http.request(request)}

    document = REXML::Document.new(response.body)
    xml=document.elements.to_a( "//Exito" )
    @texto=xml[0].to_s.to(6).to_s
    if @texto.eql?("<Exito>")
      redirect_to "/mensajes"
    else
      raise Exception.new("Error desde el servicio")
    end
  rescue Exception=>e
    xml = []
    xml=document.elements.to_a( "//Error" )
    if xml.empty?
      @texto = 'Error en el servicio (enviarComentario)'
    else
      @texto = xml[0].to_s     
    end
    respond_to do |format|
         format.html { redirect_to [@mensaje], notice: @texto }
    end
  end

  def enviarrespuesta
    @mensaje = Mensaje.new
    @mensaje_padre = params[:id]
    require 'net/http'
    require 'uri'
    require 'rexml/document'
    @mensaje = Mensaje.new
    endpoint = Net::HTTP.new(@mi_url,80)
    response = endpoint.get("/servs.xml")
#    response = endpoint.get("/ultimo/Desarroll/tags/tagspopulares")
    document = REXML::Document.new(response.body)
    xml=document.elements.to_a( "//Tags/tag" )

    @tags=[]
    contador=0

    while (contador < xml.size)

      tag = Tag.new
      tag.nombre=xml[contador][1][0]
      tag.cantidad=xml[contador][3][0]
      @tags.push(tag)
      contador=contador+1
    end    
#    redirect_to "/mensajes/enviarrespuesta"
  end

   # POST /mensajes/respuesta
  # POST /mensajes/respuesta.json
# Envia al servicio web un xml con los datos de la respuesta
  def respuesta
    require 'net/http'
    http = Net::HTTP.new(@mi_url,80)    
#    request = Net::HTTP::Post.new("Ultimo/Desarroll/mensajes/Responder/"+@token.mensaje_padre+"/"+@token.mensaje)
    request = Net::HTTP::Post.new("/servs.xml")
    request.content_type = "application/xml"
    @mensaje = Mensaje.new (params[:Mensaje])
    lista_tags = @mensaje.tags
    lista_salida = ''
    for tag in lista_tags
      lista_salida = lista_salida+'<tags>'+tag.to_s+'</tags>'
    end

    request.body = '<?xml version="1.0" encoding="UTF-8"?>
    <Mensaje>
<nombre>'+@mensaje.nombre.to_s+'</nombre>
<comentario>'+@mensaje.comentario.to_s+'</comentario>
<respuesta>'+@mensaje.respuesta.to_s+'</respuesta>
<notificacion>'+@mensaje.notificacion.to_s+'</notificacion>
<adjunto></adjunto>
<usuario>'+@mensaje.usuario.to_s+'</usuario>
'+lista_salida+'
</Mensaje>'
    
    response = http.request(request)
    response = Net::HTTP.start(@mi_url,80) {|http| http.request(request)}

    document = REXML::Document.new(response.body)
    xml=document.elements.to_a( "//Exito" )
    @texto=xml[0].to_s.to(6).to_s
    if @texto.eql?("<Exito>")
      redirect_to "/mensajes"
    else
      raise Exception.new("Error desde el servicio")
    end
  rescue Exception=>e
     xml=document.elements.to_a( "//Error" )
    @texto = xml[0].to_s
     respond_to do |format|
        format.html
      end
end

  # PUT /mensajes/1
  # PUT /mensajes/1.json
  # Envia al servicio web un xml con los datos del mensaje para ser actualizado
  def update
    @mensaje = @user.mensajes.find(params[:id])
    respond_to do |format|
      if @mensaje.update_attributes(params[:mensaje])
        format.html { redirect_to [@user,@mensaje], notice: 'mensaje was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mensaje.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mensajes/1
  # DELETE /mensajes/1.json
  # Envia al servicio web un xml con los datos del mensaje para ser eliminado
  def destroy
    @mensaje = @user.mensajes.find(params[:id])
    @mensaje.destroy
    #@user.mensajes.delete(@mensaje)
    #@user.save
    respond_to do |format|
      format.html { redirect_to user_mensajes_url }
      format.json { head :no_content }
    end
  end

end
