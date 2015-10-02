class Game

  attr_reader :board
  def initialize(board = Board.new)
    @board = board
  end



  def play
    user_input = gets.chomp
    validate_user_input(user_input)
    pos = parse(user_input)

    tile_node = board[pos]
    value = board[pos].value

    if value == :b
      game_over
    else
      reveal(tile_node)
    end
  end

  def game_over
    puts "Game Over"
  end

end
