class Comentario
  include MongoMapper::Document

  key :id_comentario, Integer
  key :mensaje, String
  key :archivo, String
  key :hora_publicacion, String
  key :me_gusta, String
  key :no_me_gusta, String
  belongs_to :user
  key :user_ids
  many :users, :in => :user_ids
  key :tag_ids, Array
  many :tags, :in => :tag_ids
  many :puntuaciones
  many :comentario
  belongs_to :comentario
end
