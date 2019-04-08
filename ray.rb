require_relative './vec3'

class Ray < Struct.new(:origin, :direction)
  def point_at_parameter(t)
    origin + direction*t
  end
end