require_relative './hitable'

class Sphere < Hitable
  attr_reader :center, :radius, :mat

  def initialize(cen, r, mat)
    @center = cen
    @radius = r
    @mat = mat
  end

  def hit(r, t_min, t_max, rec)
    oc = r.origin - center
    a = r.direction.dot(r.direction)
    b = oc.dot(r.direction)
    c = oc.dot(oc) - radius*radius
    discriminant = b*b - a*c

    if discriminant > 0
      temp = (-b - Math.sqrt(b*b-a*c))/a
      if temp < t_max && temp > t_min
        rec.t = temp
        rec.p = r.point_at_parameter(rec.t)
        rec.normal = (rec.p - center) / radius
        rec.mat = mat
        return true
      end
      temp = (-b + Math.sqrt(b*b-a*c))/a
      if temp < t_max && temp > t_min
        rec.t = temp
        rec.p = r.point_at_parameter(rec.t)
        rec.normal = (rec.p - center) / radius
        rec.mat = mat
        return true
      end
    end
    false
  end
end