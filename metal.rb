require_relative './material'

class Metal < Material
  attr_reader :albedo

  def initialize(a)
    @albedo = a
  end

  def scatter(r_in, rec, attenuation, scattered)
    reflected = r_in.direction.unit_vector.reflect(rec.normal)
    scattered.origin = rec.p
    scattered.direction = reflected
    attenuation.e[0] = albedo.e[0]
    attenuation.e[1] = albedo.e[1]
    attenuation.e[2] = albedo.e[2]
    scattered.direction.dot(rec.normal) > 0
  end
end