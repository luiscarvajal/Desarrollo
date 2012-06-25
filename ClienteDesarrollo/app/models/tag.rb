class Tag
  include MongoMapper::Document

  key :id_tag, Integer
  key :nombre, String
  key :comentario_ids, Array
  many :comentarios, :in => :comentario_ids
  
  def listar
    require 'net/http'
    require 'uri'
    require 'rexml/document'
    endpoint = Net::HTTP.new(@mi_url,@mi_puerto)
    response = endpoint.get("/tags/alltag.xml")
    document = REXML::Document.new(response.body)
    xml=document.elements.to_a( "//tags/tag" )

    @tags=[]
    contador=0

    while (contador < xml.size)

      tag=Tag.new
      tag.id=xml[contador][3][0]
      tag.nombre=xml[contador][7][0]
      @tags.push(tag)
      contador=contador+1

    end
    return @tags
  end
end
