require_relative "00_tree_node"

class KnightPathFinder
  def initialize(position)
    @starting_position = position
    @root_node = PolyTreeNode.new(position)
    @considered_pos = [position]
  end

  def self.valid_moves(pos)
    result = []
    row, col = pos
    possible_moves = [
      [row + 2, col + 1],
      [row + 1, col + 2],
      [row - 2, col + 1],
      [row - 1, col + 2],
      [row - 2, col - 1],
      [row - 1, col - 2],
      [row + 1, col - 2],
      [row + 2, col - 1]
    ]
    possible_moves.each do |subarr|
      if subarr.all? { |el| el >= 0 && el <= 7 }
        result << subarr
      end
    end
    result
  end
  
  def new_move_pos(pos)
    possible_moves = valid_moves(pos)
    possible_moves.each do |move|
      if !@considered_pos.include?(move)
        @considered_pos << move
      else
        possible_moves.delete(move)
      end
    end
    possible_moves
  end

  def build_move_tree(pos)
    return pos if new_move_pos(pos).empty?

    new_move_pos(pos).each do |ele|
      pos.add_child(PolyTreeNode.new(build_move_tree(ele)))
    end
  end

end