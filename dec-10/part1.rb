#!/usr/bin/ruby

input_array = File.readlines('input.txt')

coords_map = {}
input_array.each do |info|
  initial_position = info.split('>')[0].split('<')[1].strip
  x_pos = initial_position.split(',')[0].strip.to_i
  y_pos = initial_position.split(',')[1].strip.to_i
  velocity = info.split('<')[2].split('>')[0]
  x_vel = velocity.split(',')[0].strip.to_i
  y_vel = velocity.split(',')[1].strip.to_i
  coords_map[initial_position] = {}
  coords_map[initial_position]["current_x"] = x_pos
  coords_map[initial_position]["current_y"] = y_pos
  coords_map[initial_position]["velocity_x"] = x_vel
  coords_map[initial_position]["velocity_y"] = y_vel
end
delta_x = 100000000000000
delta_y = 100000000000000
max_x = -10000
max_y = -10000
min_x = 10000
min_y = 10000
(0..1000000).each do
  max_x = -10000
  max_y = -10000
  min_x = 10000
  min_y = 10000
  coords_map.each do |initial_coords, coords_info|
    coords_info["current_x"] = coords_info["current_x"] + coords_info["velocity_x"]
    if coords_info["current_x"] > max_x
      max_x = coords_info["current_x"]
    elsif coords_info["current_x"] < min_x
      min_x = coords_info["current_x"]
    end
    coords_info["current_y"] = coords_info["current_y"] + coords_info["velocity_y"]
    if coords_info["current_y"] > max_y
      max_y = coords_info["current_y"]
    elsif coords_info["current_y"] < min_y
      min_y = coords_info["current_y"]
    end
  end
  if max_x - min_x < delta_x
    delta_x = max_x - min_x
  else
    break
  end
  if max_y - min_y < delta_y
    delta_y = max_y - min_y
  else
    break
  end
end


coords_map.each do |initial_coords, coords_info|
  coords_info["current_x"] = coords_info["current_x"] - coords_info["velocity_x"]
  coords_info["current_y"] = coords_info["current_y"] - coords_info["velocity_y"]
end

(min_y..max_y).each do |y|
  row = []
  (min_x..max_x).each do |x|
    if coords_map.any? {|initial_coords, coords_info| x == coords_info["current_x"] && y == coords_info["current_y"] }
      row << "#"
    else
      row << "."
    end
  end
  puts "row = #{row.join}"
end
