#!/usr/bin/ruby

input_array = File.readlines('input.txt')

input_array.sort!

id_map = {}
guard_id = ''
start_time = 0
end_time = 0
input_array.each do |line|
  minutes = line.split(']')[0].split(' ')[1].split(':')[1].to_i
  info = line.split(']')[1]
  if( info.include? 'Guard' )
    guard_id = info.split(' ')[1]
    if id_map[guard_id] == nil
      id_map[guard_id] = {'minutes_asleep' => {}}
    end
  end
  if( info.include? 'asleep')
    start_time = minutes
  end
  if( info.include? 'wakes')
    end_time = minutes
    minute_array = *(start_time..(end_time-1))
    minute_array.each do |minute|
      if id_map[guard_id]['minutes_asleep'][minute] == nil
        id_map[guard_id]['minutes_asleep'][minute] = 1
      else
        id_map[guard_id]['minutes_asleep'][minute] += 1
      end
    end
  end
end

id_to_display = ''
minute_to_display = -1
max_minute_count = 0
id_map.each do |id, minute_info|
  minute_map = minute_info['minutes_asleep']
  minute_map.each do |minute, count|
    if count > max_minute_count
      max_minute_count = count
      id_to_display = id
      minute_to_display = minute
    end
  end
end

puts id_to_display
puts minute_to_display
