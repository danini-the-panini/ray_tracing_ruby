require_relative './hitable'

class HitableList < Hitable
  attr_reader :list

  def initialize(l)
    @list = l
  end

  def list_size
    list.size
  end

  def hit(r, t_min, t_max, rec)
    hit_anything = false
    closest_so_far = t_max
    list.each do |h|
      if h.hit(r, t_min, closest_so_far, rec)
        closest_so_far = rec.t
        hit_anything = true
      end
    end
    hit_anything
  end
end