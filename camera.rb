require_relative './ray'

class Camera
  attr_reader :origin, :lower_left_corner, :horizontal, :vertical

  def initialize(vfov, aspect)
    theta = vfov*Math::PI/180.0
    half_height = Math.tan(theta/2.0)
    half_width = aspect * half_height
    @lower_left_corner = Vec3.new(-half_width, -half_height, -1.0)
    @horizontal = Vec3.new(2.0*half_width, 0.0, 0.0)
    @vertical = Vec3.new(0.0, 2.0*half_height, 0.0)
    @origin = Vec3.new(0.0, 0.0, 0.0)
  end

  def get_ray(u, v)
    Ray.new(origin, lower_left_corner + horizontal*u + vertical*v - origin)
  end
end