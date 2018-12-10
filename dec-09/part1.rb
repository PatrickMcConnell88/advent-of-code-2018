#!/usr/bin/ruby

input_string = File.readlines('input.txt')[0]

number_players = input_string.split(';')[0].split(' ')[0].to_i
last_round = input_string.split(';')[1].strip.split(' ')[4].to_i
player_map = Hash[(1..number_players).map{|number| [number,0] }]

round_point = 0
marble_circle = [0]
round = 1
current_marble_index = 0
until round == last_round
  (1..number_players).each do |player|
    if round == 1
      current_marble_index = 1
      marble_circle.insert(current_marble_index,round)
    elsif round == 2
      current_marble_index = 1
      marble_circle.insert(current_marble_index,round)
    elsif (round % 23) == 0
      round_point = round
      if current_marble_index - 7 < 0
        current_marble_index = marble_circle.size + (current_marble_index - 7)
      else
        current_marble_index -= 7
      end
      round_point += marble_circle[current_marble_index]
      marble_circle.delete_at(current_marble_index)
      player_map[player] += round_point
    else
      if current_marble_index + 2 > marble_circle.size
        current_marble_index = (current_marble_index+2)%(marble_circle.size)
      else
        current_marble_index += 2
      end
      marble_circle.insert(current_marble_index, round)
    end
    if round == last_round
      break
    end
    round_point = 0
    round += 1
  end
end

high_score = player_map.values.max
puts "#{number_players} players; last marble is worth #{last_round} points: high score is #{high_score}"
