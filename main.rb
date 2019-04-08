require_relative './vec3'

nx = 200
ny = 100

puts "P3"
puts "#{nx} #{ny}"
puts "255"

(ny-1).downto(0) do |j|
  0.upto(nx-1) do |i|
    col = Vec3.new(i.to_f / nx.to_f, j.to_f / ny.to_f, 0.2)

    ir = (255.99*col[0]).to_i
    ig = (255.99*col[1]).to_i
    ib = (255.99*col[2]).to_i

    puts "#{ir} #{ig} #{ib}"
  end
end