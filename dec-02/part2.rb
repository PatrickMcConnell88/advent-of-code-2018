#!/usr/bin/ruby
input_array = File.readlines('input.txt')

length = input_array[0].length
input_array.each do |id1|
  input_array.each do |id2|
    if id1 == id2
      next
    end
    char1 = id1.chars
    char2 = id2.chars
    count = 0
    difference = 0
    while count < length
      if char1[count] != char2[count]
        difference += 1
        if difference > 1
          break
        end
      end
      count += 1
    end
    if difference == 1
      puts id1
      puts id2
    end
  end
end
