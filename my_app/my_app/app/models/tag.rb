class Tag
  include MongoMapper::Document

  key :id_tag, Integer
  key :nombre, String
  key :comentario_ids, Array
  many :comentarios, :in => :comentario_ids
end
