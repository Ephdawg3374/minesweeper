class Board
  attr_reader :grid

  def initialize(difficulty = :normal)
    @grid = create_grid(difficulty)
    assign_position_to_tile_nodes
    create_bombs
  end

  def create_grid(difficulty)
    case difficulty
    when :easy; Array.new(6) {Array.new(6) {TileNode.new(self)}}
    when :normal; Array.new(9) {Array.new(9) {TileNode.new(self)}}
    when :hard; Array.new(12) {Array.new(12) {TileNode.new(self)}}
    end
  end

  def assign_position_to_tile_nodes
    @grid.each_index do |x|
      @grid[x].each_index do |y|
        pos = [x,y]
        self[pos].position = pos
      end
    end
    nil
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

  def create_bombs
    bombs = num_of_bombs

    @grid.each_index do |x|
      @grid[x].each_index do |y|
        pos = [x,y]

        unless self[pos].value == :b
          if create_bomb?
            self[pos].value = :b
            bombs = bombs - 1
            return nil if bombs == 0
          end
        end
      end
    end

    nil
  end

  def create_bomb?
    rand(1..3) == 1 ? true : false
  end

  def num_of_bombs
    (@grid.length*@grid.length) / 3
  end
  def render
    @grid.each_index do |x|
      @grid[x].each_index do |y|
        pos = [x,y]
        if y == @grid.length - 1
          print "[#{self[pos].display}]\n"
        else
          print "[#{self[pos].display}]"
        end
      end
    end
    nil
  end

  def render_loser
    puts ":("
  end

  def won?
    all_revealed = self.grid.all? do |row|
      row.all? { |tile| tile.revealed?}
    end

    all_revealed && (num_of_flags == num_of_bombs)

  end

  def num_of_flags
    self.grid.all? do |row|
      row.find_all { |tile| tile.flagged? }
    end.count
  end


end
