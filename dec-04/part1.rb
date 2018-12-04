#!/usr/bin/ruby

input_array = [
]

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
      id_map[guard_id] = {'total_time' => 0, 'minutes_asleep' => []}
    end
  end
  if( info.include? 'asleep')
    start_time = minutes
  end
  if( info.include? 'wakes')
    end_time = minutes
    id_map[guard_id]['total_time'] += end_time - start_time
    minute_array = *(start_time..(end_time-1))
    id_map[guard_id]['minutes_asleep'] += minute_array
  end
end

max_minute = 0
id_to_display = ''
id_map.each do | id, minute_info|
  if minute_info['total_time'] > max_minute
    max_minute = minute_info['total_time']
    id_to_display = id
  end
end

minute_array = id_map[id_to_display]['minutes_asleep']
minute_map = Hash.new(0)

minute_array.each do |minute|
  minute_map[minute] += 1
end

max_minute_count = 0
minute_to_display = 0
minute_map.each do |minute, count|
  if count > max_minute_count
    max_minute_count = count
    minute_to_display = minute
  end
end
puts id_to_display
puts minute_to_display
