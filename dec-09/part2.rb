#!/usr/bin/ruby

class MarbleList
  attr_reader :value
  attr_accessor :previous_marble, :next_marble
  def initialize(value, previous_marble=nil, next_marble=nil)
    @value = value
    @previous_marble = previous_marble
    @next_marble = next_marble
  end

  def insert(value, previous_marble, next_marble)
    @value = value
    @previous_marble = previous_marble
    @next_marble = next_marble
  end

  def travel_forward
    return @next_marble
  end

  def travel_back(movement)
    marble = @previous_marble
    (2..movement).each do |count|
      marble = marble.previous_marble
    end
    return marble
  end

  def get_value_and_delete
    previous_marble = @previous_marble
    next_marble = @next_marble
    previous_marble.next_marble = next_marble
    next_marble.previous_marble = previous_marble
    return
  end

  def to_s
    puts @value
  end

end
input_string = File.readlines('input.txt')[0]

number_players = input_string.split(';')[0].split(' ')[0].to_i
last_round = input_string.split(';')[1].strip.split(' ')[4].to_i * 100
player_map = Hash[(1..number_players).map{|number| [number,0] }]

round_point = 0
marble_circle = MarbleList.new(0)
marble_circle.next_marble = marble_circle
marble_circle.previous_marble = marble_circle
round = 1
initial_marble = marble_circle
until round == last_round
  (1..number_players).each do |player|
    if (round % 23) == 0
      round_point = round
      marble_circle = marble_circle.travel_back(7)
      round_point += marble_circle.value
      player_map[player] += round_point
      before_marble = marble_circle.previous_marble
      after_marble = marble_circle.next_marble
      before_marble.next_marble = after_marble
      after_marble.previous_marble = before_marble
      marble_circle = after_marble
    else
      marble_circle = marble_circle.travel_forward
      second_marble = marble_circle.next_marble
      new_marble = MarbleList.new(round, marble_circle, second_marble)
      second_marble.previous_marble = new_marble
      marble_circle.next_marble = new_marble
      marble_circle = marble_circle.travel_forward
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
