#!/usr/bin/ruby

input_array = File.readlines('input.txt')

fabric_map = {}

input_array.each do | part |
  sub_parts = part.split
  coords = sub_parts[2].delete!(':')
  coords_array = coords.split(',')
  x_coord = coords_array[0].to_i
  y_coord = coords_array[1].to_i
  dimensions = sub_parts[3].split('x')
  width = dimensions[0].to_i
  height = dimensions[1].to_i
  x_count = x_coord
  while x_count < x_coord + width do
    y_count = y_coord
    while y_count < y_coord + height do
      if fabric_map[x_count.to_s + ',' + y_count.to_s] == nil
        fabric_map[x_count.to_s + ',' + y_count.to_s] = 1
      else
        fabric_map[x_count.to_s + ',' + y_count.to_s] += 1
      end
      y_count += 1
    end
    x_count += 1
  end
end

overlap_count = 0
fabric_map.values.each do |square|
  if square > 1
    overlap_count += 1
  end
end
puts overlap_count
