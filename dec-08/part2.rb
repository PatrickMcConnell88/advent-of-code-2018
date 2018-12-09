#!/usr/bin/ruby

class Node
  attr_reader :number_of_children, :number_of_metadata, :label
  attr_accessor :child_nodes, :metadata_entries

  def initialize(number_of_children, number_of_metadata)
    @number_of_children = number_of_children
    @number_of_metadata = number_of_metadata
    @child_nodes = []
    @metadata_entries = []
  end

  def insert_node(node)
    @child_nodes << node
  end

  def insert_metadata(metadata_entry)
    @metadata_entries << metadata_entry
  end

  def return_value
    value = 0
    if @number_of_children == 0
      value = metadata_entries.sum
    else
      metadata_entries.each do |entry|
        if entry == 0 ||  child_nodes[entry-1] == nil
          value += 0
        else
          value += child_nodes[entry-1].return_value
        end
      end
    end
    return value
  end

end

input_string = File.readlines('input.txt')[0]
number_array = input_string.split(' ').map{ |number| number.to_i }

root_node = nil
parent_node = nil
current_node = nil
flag = "number_children"
pending_nodes = []
number_of_child_nodes = 0
number_of_metadata_entries = 0
number_array.each do |number|
  case flag
  when flag = "number_children"
    number_of_child_nodes = number
    flag = "number_metadata"
  when flag = "number_metadata"
    number_of_metadata_entries = number
    if root_node == nil
      root_node = Node.new(number_of_child_nodes, number_of_metadata_entries)
      current_node = root_node
    else
      parent_node = current_node
      current_node = Node.new(number_of_child_nodes, number_of_metadata_entries)
      parent_node.insert_node(current_node)
    end
    if number_of_child_nodes > 0
      flag = "number_children"
      (1..number_of_child_nodes).each do
        pending_nodes << current_node
      end
    else
      if number_of_metadata_entries > 0
        flag = "metadata_entry"
      else
        current_node = pending_nodes.pop
        if current_node == nil
          flag = "metadata_entry"
          current_node = root_node
        elsif current_node.number_of_children == current_node.child_nodes.size
          flag = "metadata_entry"
        else
          flag = "number_children"
        end
      end
    end
  when flag = "metadata_entry"
    if current_node.number_of_metadata != current_node.metadata_entries.size
      current_node.insert_metadata(number)
    end
    if current_node.number_of_metadata == current_node.metadata_entries.size
      current_node = pending_nodes.pop
      if current_node == nil
        flag = "metadata_entry"
        current_node = root_node
      elsif current_node.number_of_children == current_node.child_nodes.size
        flag = "metadata_entry"
      else
        flag = "number_children"
      end
    end
  end
end

puts root_node.return_value
