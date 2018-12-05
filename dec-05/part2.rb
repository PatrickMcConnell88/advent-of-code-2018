#!/usr/bin/ruby

input_array = File.readlines('input.txt')
char_array = input_array[0].chars.flatten.compact
char_map = {}
char_array.each do |c|
  char_to_insert = c.downcase
  if char_map[char_to_insert] == nil
    char_map[char_to_insert] = 0
  end
end
polymer_count = 10000000000
char_map.each do |char_to_delete, total|
  char_array_copy = char_array.map(&:clone)
  char_array_copy.delete(char_to_delete)
  char_array_copy.delete(char_to_delete.upcase)
  char_array_copy.compact!
  count = 1
  while count > 0
    clear_next = false
    count = 0
    char_array_copy.map!.with_index do |c, index|
      if clear_next
        clear_next = false
        count += 1
        c = nil
      elsif char_array_copy[index +1] && c != char_array_copy[index + 1] && c.downcase == char_array_copy[index + 1].downcase
        clear_next = true
        count += 1
        c = nil
      else
        c = c
      end
    end
    char_array_copy.compact!
  end
  char_array_copy.flatten!
  char_array_copy.compact!
  if char_array_copy.size < polymer_count
    polymer_count = char_array_copy.size
  end
end

puts polymer_count - 1
