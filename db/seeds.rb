# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#Material.create(title: "クッション", price: 3500, size: 2, detail: "ふかふかです")
#Material.create(title: "トランポリン", price: 1500, size: 0, detail: "よく跳ねます")
#Category.create(material_id: 3, category: 1)
#Category.create(material_id: 4, category: 2)
Photo.create(material_id: 5, photo: File.read("#{Rails.root}/db/data/5.jpeg"))
#Photo.create(material_id: 2, photo: File.read("#{Rails.root}/db/data/2.jpeg"))
#Photo.create(material_id: 1, photo: File.read("#{Rails.root}/db/data/1.jpeg"))
#Photo.create(material_id: 6, photo: File.read("#{Rails.root}/db/data/6.jpeg"))