require_relative './material'

def schlick(cosine, ref_idx)
  r0 = (1.0-ref_idx) / (1.0+ref_idx)
  r0 = r0*r0
  r0 + (1.0-r0)*((1.0 - cosine)**5)
end

class Dielectric < Material
  attr_reader :ref_idx

  def initialize(ri)
    @ref_idx = ri
  end

  def scatter(r_in, rec, attentuation, scattered)
    outward_normal = Vec3.new
    reflected = r_in.direction.reflect(rec.normal)
    ni_over_nt = 0.0
    attentuation.e[0] = 1.0
    attentuation.e[1] = 1.0
    attentuation.e[2] = 1.0
    refracted = Vec3.new
    reflect_prob = 0.0
    cosine = 0.0
    if r_in.direction.dot(rec.normal) > 0
      outward_normal = -rec.normal
      ni_over_nt = ref_idx
      cosine = ref_idx * r_in.direction.dot(rec.normal) / r_in.direction.length
    else
      outward_normal = rec.normal
      ni_over_nt = 1.0 / ref_idx
      cosine = -r_in.direction.dot(rec.normal) / r_in.direction.length
    end
    if refracted = r_in.direction.refract(outward_normal, ni_over_nt)
      reflect_prob = schlick(cosine, ref_idx)
    else
      reflect_prob = 1.0
    end
    if rand < reflect_prob
      scattered.origin = rec.p
      scattered.direction = reflected
    else
      scattered.origin = rec.p
      scattered.direction = refracted
    end
    true
  end
end