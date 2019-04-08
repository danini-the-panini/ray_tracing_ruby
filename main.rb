require_relative './sphere'
require_relative './hitable_list'
require_relative './camera'

def random_in_unit_sphere
  p = Vec3.new
  loop do
    p = Vec3.new(rand, rand, rand)*2.0 - Vec3.new(1.0, 1.0, 1.0)
    break if p.squared_length >= 1.0
  end
  p
end

def color(r, world)
  rec = HitRecord.new
  if world.hit(r, 0.001, Float::INFINITY, rec)
    target = rec.p + rec.normal + random_in_unit_sphere
    return color(Ray.new(rec.p, target-rec.p), world)*0.5
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
ns = 100

lower_left_corner = Vec3.new(-2.0, -1.0, -1.0)
horizontal = Vec3.new(4.0, 0.0, 0.0)
vertical = Vec3.new(0.0, 2.0, 0.0)
origin = Vec3.new(0.0, 0.0, 0.0)

list = [
  Sphere.new(Vec3.new(0.0, 0.0, -1.0), 0.5),
  Sphere.new(Vec3.new(0.0, -100.5, -1.0), 100)
]
world = HitableList.new(list)

cam = Camera.new

(ny-1).downto(0) do |j|
  0.upto(nx-1) do |i|
    col = Vec3.new(0.0, 0.0, 0.0)
    0.upto(ns-1) do
      u = (i + rand).to_f / nx.to_f
      v = (j + rand).to_f / ny.to_f
      r = cam.get_ray(u, v)
      p = r.point_at_parameter(2.0)
      col += color(r, world)
    end
    col /= ns.to_f
    col = Vec3.new(Math.sqrt(col[0]), Math.sqrt(col[1]), Math.sqrt(col[2]))

    ir = (255.99*col[0]).to_i
    ig = (255.99*col[1]).to_i
    ib = (255.99*col[2]).to_i

    puts "#{ir} #{ig} #{ib}"
  end
end
