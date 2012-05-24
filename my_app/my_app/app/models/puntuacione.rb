class Puntuacione
  include MongoMapper::Document

  key :id_puntuacion, Integer
  key :mensaje,String
  key :me_gusta, Integer
  key :no_me_gusta, Integer
  belongs_to :comentario
  belongs_to :user
end
