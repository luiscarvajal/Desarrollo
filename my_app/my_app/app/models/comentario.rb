class Comentario
  include MongoMapper::Document

  key :id_comentario, Integer
  key :mensaje, String
  key :tag, String
  #key :hora_publicacion, Time
  belongs_to :user
end
