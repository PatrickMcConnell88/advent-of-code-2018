#!/usr/bin/ruby

input_array = File.readlines('input.txt')

max_x = 0
max_y = 0
min_x = 0
min_y = 0
input_array.each do | coords |
  x_coord = coords.split(', ')[0].to_i
  y_coord = coords.split(', ')[1].to_i
  if x_coord < min_x
    min_x = x_coord
  end
  if x_coord > max_x
    max_x = x_coord
  end
  if y_coord < min_y
    min_y = y_coord
  end
  if y_coord > max_y
    max_y = y_coord
  end
end
max_x += 250
min_x -= 250
max_y += 250
min_y -= 250

hash_map = {}
(min_x..max_x).each do |x|
  (min_y..max_y).each do |y|
    distance = 0
    input_array.each do |coords|
      x_coord = coords.split(', ')[0].to_i
      y_coord = coords.split(', ')[1].to_i
      distance += (x-x_coord).abs + (y-y_coord).abs
      if distance >= 10000
        break
      end
    end
    hash_map["#{x},#{y}"] = distance
  end
end
puts "hash size before reducing is: #{hash_map.size}"
# hash_map.each do |coords, distance|
#   puts "The distance is #{distance} for coord"
# end
hash_map.reject! { |coords,distance| distance >= 10000  }
hash_map = hash_map.compact
puts "hash size after reducing is: #{hash_map.size}"
