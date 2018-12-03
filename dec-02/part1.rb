#!/usr/bin/ruby

input_array = [
]

num_doubles = 0
num_triples = 0

input_array.each do |id|
  contains_double = false
  contains_triple = false

  char_array = id.chars
  hash_map = {}

  char_array.each do |char|
    if hash_map[char] == nil
      hash_map[char] = 1
    else
      hash_map[char] = hash_map[char] + 1
    end
  end

  hash_map.values.each do |value|
    if value == 2
      contains_double = true
    elsif value == 3
      contains_triple = true
    end
  end

  if contains_double
    num_doubles += 1
  end
  if contains_triple
    num_triples += 1
  end
end

puts num_doubles * num_triples
