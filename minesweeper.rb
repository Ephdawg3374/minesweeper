require 'byebug'

class Board
  attr_reader :grid

  BOARD_SIZE = 9

  def initialize(grid = Array.new(9) {Array.new(9)}, difficulty = "normal")
    @grid = grid
    @difficulty = difficulty
    create_tiles_and_bombs
  end

  def [](pos) #[1,0]
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    #debugger
    x, y = pos
    @grid[x][y] = value
  end

  def create_tiles_and_bombs
    bombs = num_of_bombs

    until bombs == 0
      0.upto(BOARD_SIZE - 1) do |x|
        0.upto(BOARD_SIZE - 1) do |y|
          pos = [x, y]
          new_tile = TileNode.new(pos, nil)
          #debugger
          if create_bomb?
            new_tile.value = :b
            bombs -= 1
          end

          self[pos] = new_tile
        end
      end
    end

    nil
  end

  def create_bomb?
    rand(0..1) == 1 ? true : false
  end


  def num_of_bombs
    case @difficulty
    when "normal"
      num_of_bombs = (@grid.length*@grid.length) / 3 # 1/3 of board are bombs
    end
    num_of_bombs
  end
end

class TileNode
  attr_accessor :value

  def initialize(pos, value)
    @pos = pos
    @value = value
  end
end

class Game
end

if __FILE__ == $PROGRAM_NAME
  a = Board.new
  p a
end
