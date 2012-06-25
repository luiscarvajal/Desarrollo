class Token
  include MongoMapper::Document

  key :mensaje, String
  key :nick, String
  key :mensaje_padre, String
  #scope :activos, where(:status => "activo")
  #scope :activos
end