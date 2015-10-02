class Board
  attr_reader :grid

  def initialize(grid = Array.new(9) {Array.new(9)}, difficulty = "normal")
    @grid = grid
    @difficulty = difficulty
    create_tiles
    create_bombs
  end

  def [](pos) #[1,0]
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def create_tiles
    # iterate through grid positions and create a tile
    0..upto(@board.length) do |x|
      0..upto(@board.length) do |y|
        pos = [x, y]
        self[pos] = TileNode.new(pos, nil)
      end
    end
  end


  def create_bombs
    case @difficulty
    when "normal"
      num_of_bombs = (@grid.length*@grid.length) / 3 # 1/3 of board are bombs
    end
  end
end

class TileNode
  def initialize(pos, value)
    @pos = pos
    @value = value
  end
end

class Game
end
