require_relative './vec3'

class Ray
  attr_reader :a, :b

  def initialize(a, b)
    @a = a
    @b = b
  end

  def origin
    a
  end

  def direction
    b
  end

  def point_at_parameter(t)
    a + t*b
  end
end