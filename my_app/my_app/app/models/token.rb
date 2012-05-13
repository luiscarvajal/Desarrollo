class Token
  include MongoMapper::EmbeddedDocument

  key :hora_ini, String
  key :status, String
  key :ip, String
  key :mensaje, String
  #scope :activos, where(:status => "activo")
  #scope :activos
end