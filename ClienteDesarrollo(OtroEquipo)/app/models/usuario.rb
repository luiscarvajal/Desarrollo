class Usuario
  include MongoMapper::Document

  key :id_usuario, Integer
  key :nombre, String
  key :apellido, String
  key :correo, String
  key :nick, String
  key :fecha_nac, String
  key :pais_origen, String
  key :biografia, String
  key :Password, String
  key :foto, String
end
