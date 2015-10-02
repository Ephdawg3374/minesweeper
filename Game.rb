class Game

  attr_reader :board
  def initialize(board = Board.new)
    @board = board
  end

  def play
    until game_over?
      board.render

      user_input = ""

      loop do
        puts "Enter coordinates"
        user_input = gets.chomp
        break if valid_user_input?(user_input)
      end

      pos = parse(user_input)
      p pos
      if board[pos].value == :b
        board.render_loser
        puts "game over son"
        return
      else
        board[pos].reveal
        #board.render
      end
    end
  end

  def valid_user_input?(user_input)
    !(user_input =~ /\d+,\s*\d+/).nil?
  end

  def parse(user_input)
    user_input.split(',').map(&:to_i)
  end

  def game_over?

  end

end
