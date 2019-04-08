require_relative './sphere'
require_relative './hitable_list'
require_relative './camera'
require_relative './lambertian'
require_relative './metal'
require_relative './dielectric'

def random_in_unit_sphere
  p = Vec3.new
  loop do
    p = Vec3.new(rand, rand, rand)*2.0 - Vec3.new(1.0, 1.0, 1.0)
    break if p.squared_length >= 1.0
  end
  p
end

def color(r, world, depth)
  rec = HitRecord.new
  if world.hit(r, 0.001, Float::INFINITY, rec)
    scattered = Ray.new
    attenuation = Vec3.new

    if depth < 50 && rec.mat.scatter(r, rec, attenuation, scattered)
      attenuation.mul(color(scattered, world, depth+1))
    else
      Vec3.new(0.0, 0.0, 0.0)
    end
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

r = Math.cos(Math::PI/4.0)
list = [
  Sphere.new(Vec3.new(0.0, 0.0, -1.0), 0.5, Lambertian.new(Vec3.new(0.3, 0.3, 0.8))),
  Sphere.new(Vec3.new(0.0, -100.5, -1.0), 100, Lambertian.new(Vec3.new(0.8, 0.8, 0.0))),
  Sphere.new(Vec3.new(1.0, 0.0, -1.0), 0.5, Metal.new(Vec3.new(0.8, 0.6, 0.2), 0.3)),
  Sphere.new(Vec3.new(-1.0, 0.0, -1.0), 0.5, Dielectric.new(1.5)),
  Sphere.new(Vec3.new(-1.0, 0.0, -1.0), -0.45, Dielectric.new(1.5))
]
world = HitableList.new(list)

lookfrom = Vec3.new(3.0, 3.0, 2.0)
lookat = Vec3.new(0.0, 0.0, -1.0)
dist_to_focus = (lookfrom-lookat).length
aperture = 2.0

cam = Camera.new(lookfrom, lookat, Vec3.new(0.0, 1.0, 0.0), 20.0, nx.to_f/ny.to_f, aperture, dist_to_focus)

total = nx*ny
prog = 0
(ny-1).downto(0) do |j|
  0.upto(nx-1) do |i|
    col = Vec3.new(0.0, 0.0, 0.0)
    0.upto(ns-1) do
      u = (i + rand).to_f / nx.to_f
      v = (j + rand).to_f / ny.to_f
      r = cam.get_ray(u, v)
      col += color(r, world, 0)
    end
    col /= ns.to_f
    col = Vec3.new(Math.sqrt(col[0]), Math.sqrt(col[1]), Math.sqrt(col[2]))

    ir = (255.99*col[0]).to_i
    ig = (255.99*col[1]).to_i
    ib = (255.99*col[2]).to_i

    puts "#{ir} #{ig} #{ib}"

    prog += 1
    $stderr.print("#{(prog.to_f/total.to_f*100.0).to_i}%\r")
  end
end
