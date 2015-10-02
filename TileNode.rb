class TileNode

  POSSIBLE_DIRECTIONS = [
    [-1,-1],
    [-1, 0],
    [-1, 1],
    [ 0,-1],
    [ 0, 1],
    [ 1,-1],
    [ 1, 0],
    [ 1, 1]
  ]

  attr_accessor :value, :position
  attr_reader :parent, :children, :board

  def initialize(board, position = [])
    @parent = nil
    @children = []
    @value = " "
    @position = position
    @board = board
  end

  def parent=(node)
    return if node.children.include?(self) unless node.nil?

    parent.children.delete(self) unless parent.nil?
    @parent = node
    parent.children << self unless node.nil?

    self
  end

  def reveal

    adjacent = self.adjacent_tiles(board)
    num_of_bombs = 0
    adjacent.each { |tile| num_of_bombs += 1 if tile.value == :b }

    # check if there are any adjacent bombs
    if adjacent.any? {|tile| tile.value == :b}
      self.value = num_of_bombs
      return
    end

    # there are no adjacent bombs
    self.value = :_

    adjacent.each { |node| node.reveal unless node.revealed? }
  end

  def bombed?
    self.value == :b
  end

  def flagged?
    self.value == :f
  end

  def revealed?
    tile_is = self.value
    tile_is !=  " "
  end

  def adjacent_tiles(board)
    positions = []
    curr_x, curr_y = position
    POSSIBLE_DIRECTIONS.each do |x, y|
      new_pos = [curr_x + x, curr_y + y]

      if new_pos.all? {|p| p.between?(0,9)}
       positions << new_pos
     end
    end

    neighbors = []

    positions.each { |pos| neighbors << board[pos] }
    neighbors
  end

end
