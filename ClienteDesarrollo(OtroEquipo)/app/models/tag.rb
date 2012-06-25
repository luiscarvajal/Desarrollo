class Tag
  include MongoMapper::Document

  key :nombre, String
  key :cantidad, String
end
