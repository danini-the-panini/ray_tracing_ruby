require_relative './material'

class Lambertian < Material
  attr_reader :albedo

  def initialize(a)
    @albedo = a
  end

  def scatter(r_in, rec, attenuation, scattered)
    target = rec.p + rec.normal + random_in_unit_sphere
    scattered.origin = rec.p
    scattered.direction = target-rec.p
    attenuation.e[0] = albedo.e[0]
    attenuation.e[1] = albedo.e[1]
    attenuation.e[2] = albedo.e[2]
    true
  end
end