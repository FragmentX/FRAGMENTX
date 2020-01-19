# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create([
  {name: 'Sculpture', nombre: 'Escultura'},
  {name: 'Religious object', nombre: 'Objeto de culto'},
  {name: 'Decoration', nombre: 'Objeto decorativo'},
  {name: 'Usage object', nombre: 'Objeto de uso'},
  {name: 'Container', nombre: 'Recipiente contenedor'},
  {name: 'Tool', nombre: 'Herramienta'},
  {name: 'Other', nombre: 'Otros'}
])

Material.create([
  {name: 'Ceramic', nombre: 'Cerámica'},
  {name: 'Glass', nombre: 'Vidrio'},
  {name: 'Stone', nombre: 'Piedra'},
  {name: 'Plaster / Cast', nombre: 'Yeso'},
  {name: 'Wood', nombre: 'Madera'},
  {name: 'Metal', nombre: 'Metal'},
  {name: 'Bones', nombre: 'Hueso'},
  {name: 'Ivory', nombre: 'Marfil'},
  {name: 'Other', nombre: 'Otros'}
])

State.create([
  {name: 'Optimal', nombre: 'Óptimo'},
  {name: 'Requires preventive actions', nombre: 'Requiere acciones externas preventivas'},
  {name: 'Requires curative actions', nombre: 'Requiere acciones directas curativas'},
  {name: 'Requires restoration', nombre: 'Requiere restauración'},
  {name: 'Requires preventive and curative actions', nombre: 'Requiere acciones preventivas y curativas'},
  {name: 'Requires preventive and restorative actions', nombre: 'Requiere acciones preventivas y restauración'},
  {name: 'Requires curative and restorative actions', nombre: 'Requiere acciones curativas y restauración'},
  {name: 'Requires preventive, curative and restorative actions', nombre: 'Requiere acciones preventivas, curativas y restauración'},
  {name: 'Unknown', nombre: 'Sin determinar'}
])

Deterioration.create([
  {name: 'Physical deterioration', nombre: 'Alteraciones físicas'},
  {name: 'Chemical deterioration', nombre: 'Alteraciones químicas'},
  {name: 'Biological deterioration', nombre: 'Alteraciones biológicas'}
])

Priority.create([
  {name: 'None', nombre: 'No requiere'},
  {name: 'Not immediate', nombre: 'No es inmediata'},
  {name: 'Immediate', nombre: 'Es inmediata'},
  {name: 'Not defined', nombre: 'No se ha determinado'}
])

Protection.create([
  {name: 'None', nombre: 'No tiene'},
  {name: 'BIC', nombre: 'BIC'},
  {name: 'Well stocked in inventory', nombre: 'Bien inventariado'},
  {name: 'Other', nombre: 'Otros'}
])

Units.create([
  {name: 'm'},
  {name: 'cm'},
  {name: 'mm'},
  {name: 'in'},
  {name: 'ft'}
])