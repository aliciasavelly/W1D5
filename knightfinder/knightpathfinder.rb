require_relative '00_tree_node.rb'
class KnightPathFinder
  DELTAS = [[-1,-2],[-2,-1],[-2,1],[-1,2], [1,-2],[2,-1],[2,1],[1,2]]

  attr_reader :visited_positions, :root_node

  def self.valid_moves(pos)
    moves = DELTAS.map{|delta| [delta[0] + pos[0],delta[1] + pos[1]]}
    moves.select{|pos| pos[0].between?(0,7) && pos[1].between?(0,7)}
  end

  def initialize(pos = [0,0])
    @root_node = PolyTreeNode.new(pos)
    @visited_positions = [pos]
  end

  def build_move_tree
    queue = [root_node]
    until queue.empty?
      current_node = queue.shift
      queue += children(current_node)
    end
  end

  def children(node)
    possible_pos = new_move_positions(node.value)
    children = []
    possible_pos.each do |pos|
      node_child = PolyTreeNode.new(pos)
      node_child.parent = node
      node.add_child(node_child)
      children << node_child
    end
    children
  end

  def find_path(pos)
    trace_path_back(root_node.dfs(pos))
  end

  def trace_path_back(node)
    path = []
    until node.nil?
      path << node.value
      node = node.parent
    end
    path.reverse
  end

  def new_move_positions(pos)
    possible_moves = KnightPathFinder.valid_moves(pos)
    possible_moves = possible_moves.reject{|pos| @visited_positions.include?(pos)}
    @visited_positions += possible_moves
    possible_moves
  end

end

knight = KnightPathFinder.new
knight.build_move_tree
p knight.find_path([7, 6]).length == [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]].length
p knight.find_path([6, 2]).length == [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]].length
