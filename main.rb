require_relative './ray'

def hit_sphere(center, radius, r)
  oc = r.origin - center
  a = r.direction.dot(r.direction)
  b = 2.0 * oc.dot(r.direction)
  c = oc.dot(oc) - radius*radius
  discriminant = b*b - 4.0*a*c
  if discriminant < 0
    -1.0
  else
    (-b - Math.sqrt(discriminant)) / (2.0*a)
  end
end

def color(r)
  t = hit_sphere(Vec3.new(0.0, 0.0, -1.0), 0.5, r)
  if t > 0.0
    n = (r.point_at_parameter(t) - Vec3.new(0.0, 0.0, -1.0)).unit_vector
    return Vec3.new(n.x+1.0, n.y+1.0, n.z+1.0)*0.5
  end
  unit_direction = r.direction.unit_vector
  t = 0.5*(unit_direction.y + 1.0)
  Vec3.new(1.0, 1.0, 1.0)*(1.0-t) + Vec3.new(0.5, 0.7, 1.0)*t
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

(ny-1).downto(0) do |j|
  0.upto(nx-1) do |i|
    u = i.to_f / nx.to_f
    v = j.to_f / ny.to_f


    r = Ray.new(origin, lower_left_corner + horizontal*u + vertical*v)


    col = color(r)

    ir = (255.99*col[0]).to_i
    ig = (255.99*col[1]).to_i
    ib = (255.99*col[2]).to_i

    puts "#{ir} #{ig} #{ib}"
  end
end
