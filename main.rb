require_relative './sphere'
require_relative './hitable_list'

def color(r, world)
  rec = HitRecord.new
  if world.hit(r, 0.0, Float::INFINITY, rec)
    return Vec3.new(rec.normal.x+1.0, rec.normal.y+1.0, rec.normal.z+1.0)*0.5
  else
    unit_direction = r.direction.unit_vector
    t = 0.5*(unit_direction.y + 1.0)
    Vec3.new(1.0, 1.0, 1.0)*(1.0-t) + Vec3.new(0.5, 0.7, 1.0)*t
  end
end

nx = 200
ny = 100

puts "P3"
puts "#{nx} #{ny}"
puts "255"

lower_left_corner = Vec3.new(-2.0, -1.0, -1.0)
horizontal = Vec3.new(4.0, 0.0, 0.0)
vertical = Vec3.new(0.0, 2.0, 0.0)
origin = Vec3.new(0.0, 0.0, 0.0)

list = [
  Sphere.new(Vec3.new(0.0, 0.0, -1.0), 0.5),
  Sphere.new(Vec3.new(0.0, -100.5, -1.0), 100)
]
world = HitableList.new(list)

(ny-1).downto(0) do |j|
  0.upto(nx-1) do |i|
    u = i.to_f / nx.to_f
    v = j.to_f / ny.to_f
    r = Ray.new(origin, lower_left_corner + horizontal*u + vertical*v)

    p = r.point_at_parameter(2.0)
    col = color(r, world)

    ir = (255.99*col[0]).to_i
    ig = (255.99*col[1]).to_i
    ib = (255.99*col[2]).to_i

    puts "#{ir} #{ig} #{ib}"
  end
end
