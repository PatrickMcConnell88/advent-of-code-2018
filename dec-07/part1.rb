#!/usr/bin/ruby
require 'set'
input_array = File.readlines('input.txt')

steps = Set.new([])

hash_map = {}
input_array.map do | line |
  required_step = line.split(' ')[1]
  step = line.split(' ')[7]
  steps << step
  steps << required_step
  if hash_map[step] == nil
    hash_map[step] = [required_step]
  else
    hash_map[step] << required_step
  end
end

final_answer = []
inserted_steps = []
while final_answer.size < steps.size
  pending_steps = []
  steps.each do |step|
    if hash_map[step] == nil
      pending_steps << step
    end
    if hash_map[step] != nil && (hash_map[step]&inserted_steps).size == hash_map[step].size
      pending_steps << step
    end
  end
  pending_steps.reject!{|step| inserted_steps.include? step }
  inserted_steps << pending_steps.min
  final_answer << pending_steps.min
end

puts "#{final_answer.join}"
