class Game

  attr_reader :board
  def initialize(board = Board.new)
    @board = board
  end

  def revealed_or_flagged?(pos)
    @board[pos].revealed? || @board[pos].flagged?
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

      r_or_f = user_input[0]

      pos = parse(user_input)

      if revealed_or_flagged?(pos) && r_or_f == "r"
          puts "#{pos} is already revealed or flagged on the board! Try again"
          play
      end

      if r_or_f == "r"
        if board[pos].value == :b
          board.render_loser
          puts "game over son"
          return
        else
          board[pos].reveal
          #board.render
        end
      else
        board[pos].flag
      end
    end
  end

  def valid_user_input?(user_input)
    !(user_input =~ /^[rf]\s*\d+,\s*\d+/).nil?
  end

  def parse(user_input)
    user_input[1..-1].split(',').map(&:to_i)
  end

  def game_over?

  end

end
