class Token
  include MongoMapper::Document

  key :id_usuario, Integer
  key :hora_ini, Time
  key :status, String

end
