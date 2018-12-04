#!/usr/bin/ruby
array = File.readlines('input.txt')

position = 0

duplicate_found = false

duplicate_values = {0=>true}

while !duplicate_found do
  array.each do | number |
    position = position + number.to_i
    if duplicate_values.has_key? position
      puts position
      duplicate_found = true
      break
    else
      duplicate_values[position] = true
    end
  end
end
