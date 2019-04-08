require_relative './ray'

def random_in_unit_disk
  p = Vec3.new
  loop do
    p = Vec3.new(rand, rand, 0.0)*2.0 - Vec3.new(1.0, 1.0, 0.0)
    break if p.dot(p) >= 1.0
  end
  p
end

class Camera
  attr_reader :origin, :lower_left_corner, :horizontal, :vertical, :u, :v, :w, :lens_radius

  def initialize(lookfrom, lookat, vup, vfov, aspect, aperture, focus_dist)
    @lens_radius = aperture / 2.0
    theta = vfov*Math::PI/180.0
    half_height = Math.tan(theta/2.0)
    half_width = aspect * half_height
    @origin = lookfrom
    @w = (lookfrom - lookat).unit_vector
    @u = vup.cross(w).unit_vector
    @v = w.cross(u)
    @lower_left_corner = origin - u*focus_dist*half_width - v*focus_dist*half_height - w*focus_dist
    @horizontal = u*2.0*focus_dist*half_width
    @vertical = v*2.0*focus_dist*half_height
  end

  def get_ray(s, t)
    rd = random_in_unit_disk*lens_radius
    offset = u * rd.x + v * rd.y
    Ray.new(origin + offset, lower_left_corner + horizontal*s + vertical*t - origin - offset)
  end
end