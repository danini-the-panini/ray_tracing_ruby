require_relative './material'

class Dielectric < Material
  attr_reader :ref_idx

  def initialize(ri)
    @ref_idx = ri
  end

  def scatter(r_in, rec, attentuation, scattered)
    outward_normal = Vec3.new
    reflected = r_in.direction.reflect(rec.normal)
    ni_over_nt = nil
    attentuation.e[0] = 1.0
    attentuation.e[1] = 1.0
    attentuation.e[2] = 1.0
    refracted = Vec3.new
    if r_in.direction.dot(rec.normal) > 0
      outward_normal = -rec.normal
      ni_over_nt = ref_idx
    else
      outward_normal = rec.normal
      ni_over_nt = 1.0 / ref_idx
    end
    if refracted = r_in.direction.refract(outward_normal, ni_over_nt)
      scattered.origin = rec.p
      scattered.direction = refracted
    else
      scattered.origin = rec.p
      scattered.direction = reflected
      return false
    end
    true
  end
end