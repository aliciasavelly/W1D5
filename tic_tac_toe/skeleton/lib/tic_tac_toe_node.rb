require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if board.over?
      return false if  board.winner == evaluator || board.tied?
      return true if  board.winner != evaluator
    else
      if next_mover_mark == evaluator
        children.each do |child|
          result = child.losing_node?(evaluator)
          return result unless result
        end
      else
        children.each do |child|
          result = child.losing_node?(evaluator)
          return result if result
        end
      end

    end
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    board.rows.each_with_index do |row,i|
      row.each_with_index do |mark , j|
        unless mark
          child_board = board.dup
          child_board[i, j] = next_mover_mark
          children << TicTacToeNode.new(child_board, other_mark ,[i,j])
        end
      end
    end

    children
  end

  def other_mark
    next_mover_mark == :x ? :o : :x
  end
end
