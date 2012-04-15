# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
class AddVideoToComentarios < ActiveRecord::Migration
  def up
    add_column :comentarios, :ruta_video, :string
  end
  def down
    remove_column :comentarios, :ruta_video
  end
end