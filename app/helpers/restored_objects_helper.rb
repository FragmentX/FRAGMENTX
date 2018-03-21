module RestoredObjectsHelper
  def dimensions(object)
    u = object.units.name
    "#{object.width} #{u} x #{object.height} #{u} x #{object.depth} #{u}"
  end
end
