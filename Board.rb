class Board
  attr_reader :grid

  def initialize(difficulty = :normal)
    @grid = create_grid(difficulty)
    create_bombs
  end

  def create_grid(difficulty)
    case difficulty
    when :easy; Array.new(6) {Array.new(6) {TileNode.new}}
    when :normal; Array.new(9) {Array.new(9) {TileNode.new}}
    when :hard; Array.new(12) {Array.new(12) {TileNode.new}}
    end
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

        #might need to look at this
        self[pos].position = pos

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
    num_of_bombs = (@grid.length*@grid.length) / 3 # 1/3 of board are bombs
  end

  def render
    @grid.each_index do |x|
      @grid[x].each_index do |y|
        pos = [x,y]
        if y == @grid.length - 1
          print "[#{self[pos].value}]\n"
        else
          print "[#{self[pos].value}]"
        end
      end
    end
    nil
  end

end
