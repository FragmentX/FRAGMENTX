# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create([
  {name: 'Escultura'},
  {name: 'Objeto de culto'},
  {name: 'Objeto decorativo'},
  {name: 'Objeto de uso'},
  {name: 'Recipiente contenedor'},
  {name: 'Herramienta'},
  {name: 'Otros'}
])

Material.create([
  {name: 'Cerámica'},
  {name: 'Vidrio'},
  {name: 'Piedra'},
  {name: 'Yeso'},
  {name: 'Madera'},
  {name: 'Metal'},
  {name: 'Hueso'},
  {name: 'Marfil'},
  {name: 'Otros'}
])

State.create([
  {name: 'Óptimo'},
  {name: 'Requiere acciones externas preventivas'},
  {name: 'Requiere acciones directas curativas'},
  {name: 'Requiere restauración'},
  {name: 'Requiere acciones preventivas y curativas'},
  {name: 'Requiere acciones preventivas y restauración'},
  {name: 'Requiere acciones curativas y restauración'},
  {name: 'Requiere acciones preventivas, curativas y restauración'},
  {name: 'Sin determinar'}
])

Deterioration.create([
  {name: 'Alteraciones físicas'},
  {name: 'Alteraciones químicas'},
  {name: 'Alteraciones biológicas'}
])

Priority.create([
  {name: 'No requiere'},
  {name: 'No es inmediata'},
  {name: 'Es inmediata'},
  {name: 'No se ha determinado'}
])

Protection.create([
  {name: 'No tiene'},
  {name: 'BIC'},
  {name: 'Bien inventariado'},
  {name: 'Otros'}
])

Units.create([
  {name: 'm'},
  {name: 'cm'},
  {name: 'mm'},
  {name: 'in'},
  {name: 'ft'}
])