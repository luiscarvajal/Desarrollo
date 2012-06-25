class User
  include MongoMapper::Document
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


  key :id_usuario, Integer
  key :nombre, String
  key :apellido, String
  key :correo, String
  key :nick_name, String
  key :fechaNacimiento, Date
  key :pais, String
  key :biografia, String
  key :password, String
  key :foto, String
  many :comentarios
  many :puntuaciones
  many :tokens

  def buscar_nick_name(nick_name)
    get_ip
    require 'net/http'
    require 'uri'
    require 'rexml/document'
    endpoint = Net::HTTP.new(get_ip,get_port)
    response = endpoint.get("/users.xml")
    document = REXML::Document.new(response.body)
    xml=document.elements.to_a( "//users/user" )

    @users=[]
    contador=0
    flag = false
    while (contador < xml.size)

      user=User.new
      user.apellido=xml[contador][1][0]
      user.biografia=xml[contador][3][0]
      user.correo=xml[contador][5][0]
      user.foto=xml[contador][7][0]
      user.id=xml[contador][9][0]
      user.nick_name=xml[contador][11][0]
      user.nombre=xml[contador][13][0]
      user.pais=xml[contador][15][0]
      user.password=xml[contador][17][0]
      if (user.nick_name.to_s==nick_name.to_s)
        return user
      end
      contador=contador+1

    end
    if flag == false
      user=User.new
      return user
    end
  end

end
