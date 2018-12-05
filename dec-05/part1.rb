#!/usr/bin/ruby

input_array = File.readlines('input.txt')

char_array = input_array[0].strip.chars

count = 1
while count > 0
  clear_next = false
  count = 0
  char_array.map!.with_index do |c, index|
    if clear_next
      clear_next = false
      count += 1
      c = nil
    elsif char_array[index +1] && c != char_array[index + 1] && c.downcase == char_array[index + 1].downcase
      clear_next = true
      count += 1
      c = nil
    else
      c = c
    end
  end
  char_array.compact!
end

char_array.flatten!
char_array.compact!
puts char_array.size
