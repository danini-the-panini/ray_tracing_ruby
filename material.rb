require_relative './hitable'

class Material
  def scatter(r_in, rec, attenuation, scattered)
    raise "not implemented"
  end
end