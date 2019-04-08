require_relative './ray'

class Camera
  attr_reader :origin, :lower_left_corner, :horizontal, :vertical

  def initialize(lookfrom, lookat, vup, vfov, aspect)
    theta = vfov*Math::PI/180.0
    half_height = Math.tan(theta/2.0)
    half_width = aspect * half_height
    @origin = lookfrom
    w = (lookfrom - lookat).unit_vector
    u = vup.cross(w).unit_vector
    v = w.cross(u)
    @lower_left_corner = origin - u*half_width - v*half_height - w
    @horizontal = u*2.0*half_width
    @vertical = v*2.0*half_height
  end

  def get_ray(u, v)
    Ray.new(origin, lower_left_corner + horizontal*u + vertical*v - origin)
  end
end