class Gestion_login_csv
 
  def mi_create(sesion)
    require 'net/http'
    require 'uri'
    require 'rexml/document'
    http = Net::HTTP.new(@mi_url,3000)
    request = Net::HTTP::Post.new("/users/login.xml")
    @misession = Session.new(sesion)
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
end
