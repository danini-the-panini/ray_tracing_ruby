nx = 200
ny = 100

puts "P3"
puts "#{nx} #{ny}"
puts "255"

(ny-1).downto(0) do |j|
  0.upto(nx-1) do |i|
    r = i.to_f / nx.to_f
    g = j.to_f / ny.to_f
    b = 0.2

    ir = (255.99*r).to_i
    ig = (255.99*g).to_i
    ib = (255.99*b).to_i

    puts "#{ir} #{ig} #{ib}"
  end
end