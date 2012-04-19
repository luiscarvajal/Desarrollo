class User
  include MongoMapper::Document

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
end
