#!/usr/bin/ruby

input_array = [
]

fabric_map = {}
id_map = {}

input_array.each do | part |
  sub_parts = part.split
  id = sub_parts[0]
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
        fabric_map[x_count.to_s + ',' + y_count.to_s] = [id]
        if id_map[id] == nil
          id_map[id] = true
        end
      else
        id_array = fabric_map[x_count.to_s + ',' + y_count.to_s]
        if !id_array.include? id
          id_array << id
          id_array.each do |id_to_eliminate|
            id_map[id_to_eliminate] = false
          end
        end
      end
      y_count += 1
    end
    x_count += 1
  end
end

winning_id = 0
id_map.each do |id_number, value|
  if value
    winning_id = id_number
    break
  end
end

puts winning_id
