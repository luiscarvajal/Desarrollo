class Session
  include MongoMapper::Document

  key :nick_name, String
  key :password, String
  key :mensaje, String
end