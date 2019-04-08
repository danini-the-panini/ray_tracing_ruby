require_relative './ray'

class Camera
  attr_reader :origin, :lower_left_corner, :horizontal, :vertical

  def initialize
    @lower_left_corner = Vec3.new(-2.0, -1.0, -1.0)
    @horizontal = Vec3.new(4.0, 0.0, 0.0)
    @vertical = Vec3.new(0.0, 2.0, 0.0)
    @origin = Vec3.new(0.0, 0.0, 0.0)
  end

  def get_ray(u, v)
    Ray.new(origin, lower_left_corner + horizontal*u + vertical*v - origin)
  end
end