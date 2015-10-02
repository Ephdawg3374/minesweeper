class Game

  attr_reader :board
  def initialize(board = Board.new)
    @board = board
  end

  def reveal(pos)
    current_node = @board[pos]
    adjacent = current_node.adjacent_tiles(board)
    num_of_bombs = 0
    adjacent.each { |tile| num_of_bombs += 1 if tile.value == :b }

    # check if there are any adjacent bombs
    if adjacent.any? {|tile| tile.value == :b}
      current_node.value = num_of_bombs
      return
    end

    # there are no adjacent bombs
    #if adjacent.all? { |tile| tile.value != :b } # no adjacent bombs
    current_node.value = :_

    adjacent.each { |node| reveal(node.position) unless node.revealed? }
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
