#!/usr/bin/ruby
array = File.readlines('input.txt')

position = 0

array.each do | number |
  position = position + number.to_i
end
puts position
