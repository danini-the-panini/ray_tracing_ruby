require_relative './ray'

HitRecord = Struct.new(:t, :p, :normal)

class Hitable
  def hit(r, t_min, t_max, rec)
    raise "not implemented"
  end
end