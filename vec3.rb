class Vec3
  attr_reader :e

  def initialize(e0=0.0, e1=0.0, e2=0.0)
    @e = [e0, e1, e2]
  end

  def x; e[0]; end
  def y; e[1]; end
  def z; e[2]; end
  def r; e[0]; end
  def g; e[1]; end
  def b; e[2]; end

  def +@
    self
  end

  def -@
    Vec3.new(-e[0], -e[1], -e[2])
  end

  def [](i)
    e[i]
  end

  def []=(i, v)
    e[i] = v
  end

  def +(v2)
    Vec3.new(self.e[0] + v2.e[0], self.e[1] + v2.e[1], self.e[2] + v2.e[2])
  end

  def -(v2)
    Vec3.new(self.e[0] - v2.e[0], self.e[1] - v2.e[1], self.e[2] - v2.e[2])
  end

  def *(t)
    Vec3.new(t*self.e[0], t*self.e[1], t*self.e[2])
  end

  def /(t)
    Vec3.new(self.e[0]/t, self.e[1]/t, self.e[2]/t)
  end

  def dot(v2)
    self.e[0] * v2.e[0] + self.e[1] * v2.e[1] + self.e[2] * v2.e[2]
  end

  def cross(v2)
    Vec3.new((self.e[1]*v2.e[2] - self.e[2]*v2.e[1]),
            -(self.e[0]*v2.e[2] - self.e[2]*v2.e[0]),
             (self.e[0]*v2.e[1] - self.e[1]*v2.e[0]))
  end

  def mul(v2)
    Vec3.new(self.e[0]*v2.e[0], self.e[1]*v2.e[1], self.e[2]*v2.e[2])
  end

  def to_s
    "#{e[0]} #{e[1]} #{e[2]}"
  end

  def length
    Math.sqrt(e[0]*e[0] + e[1]*e[1] + e[2]*e[2])
  end

  def squared_length
    e[0]*e[0] + e[1]*e[1] + e[2]*e[2]
  end

  def make_unit_vector
    k = 1.0 / Math.sqrt(e[0]*e[0] + e[1]*e[1] + e[2]*e[2])
    e[0] *= k; e[1] *= k; e[2] *= k
  end

  def unit_vector
    self / self.length
  end

  def reflect(n)
    self - n*2.0*self.dot(n)
  end
end
