require 'debugger'

class Node
  attr_accessor :neighbors, :value

  def initialize(value)
    @value = value
    @neighbors = {}
  end

  def add_neighbor(neighbor, weight = 1)
    @neighbors[neighbor.value] = [neighbor, weight]
  end

  def adjacent?(neighbor)
    @neighbors.keys.include?(neighbor.value)
  end

  def adjacent_val?(neighbor)
    @neighbors.keys.include?(neighbor)
  end
end

class Graph
  attr_accessor :nodes

  def initialize
    @nodes = {}
  end

  def add_node_by_value(val)
    @nodes[val] = Node.new(val)
  end

  def add_node node
    @nodes[node.value] = node
  end

  def add_edge_by_value(from, to, weight = 1)
    @nodes[from].add_neighbor(to, weight)
  end

  def add_edge(from, to, weight = 1)
    @nodes[from.value].add_neighbor(to, weight)
  end

  def adjacent?(from, to)
    @nodes[from.value].adjacent?(to)
  end

  def adjacent_by_value(from, to)
    @nodes[from].adjacent?(to)
  end

  def edge_value(from, to)
    @nodes[from.value].neighbors[to.value][1] if @nodes[from.value].neighbors[to.value]
  end
end
