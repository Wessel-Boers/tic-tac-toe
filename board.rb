class Board
  attr_accessor :board, :squares

  def initialize
    @board = """
      1 | 2 | 3 
      —————————
      4 | 5 | 6
      —————————
      7 | 8 | 9
    """
    @squares = {1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil}
  end

  def draw_board
    puts @board
  end

  def replace_letter(square, symbol)
    @board.sub!(square, symbol)
  end

  def update_squares(square, player)
    # Change square (key) based on which player chose it
    if player == 1
      @squares[square.to_i] = true
    elsif player == 2
      @squares[square.to_i] = false
    end
  end

  def not_chosen_before?(square)
    if @squares[square.to_i] == nil
      return true
    else
      return false
    end
  end
end