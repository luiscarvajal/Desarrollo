class Mensaje
  include MongoMapper::Document
  key :id, String
  key :me_gusta, Integer
  key :no_me_gusta, Integer
  key :nombre, String
  key :nick_name, String
  key :comentario, String
  key :video, String
  key :fechacreacion, String
  key :respuesta, Boolean
  key :notificacion, Boolean
  key :adjunto, String
  key :usuario, String
  key :tags, Array
  key :adjuntos, Array
  key :usuariosmegusta, Array
  key :usuariosnomegusta, Array
end
