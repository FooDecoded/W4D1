require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    opponent = evaluator == :o ? :x : :o
    if @board.over? && @board.winner == opponent
      return true
    elsif @board.over? && @board.winner.nil?
      return false
    end
    
    child_nodes = children
    condition1 =child_nodes.all? do |node|
      mark = node.next_mover_mark
      node.losing_node?(mark)
    end
    



  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children_state = []
    @board.rows.each_with_index do |row, row_idx|
      row.each_with_index do |el, col_idx|
        duped_state = @board.dup()
        if el.nil?
          duped_state[[row_idx, col_idx]]= @next_mover_mark
          next_marker =  @next_mover_mark == :o ? :x : :o
          children_state << TicTacToeNode.new(duped_state, next_marker, [row_idx, col_idx])
        end
      end
    end
    children_state
  end
end
