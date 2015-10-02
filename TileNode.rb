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

  attr_accessor :value, :parent, :children, :position

  def initialize(value = " ", position = [])
    @parent = nil
    @children = []
    @value = value
    @position = position
  end

  def parent=(node)
    return if node.children.include?(self) unless node.nil?

    parent.children.delete(self) unless parent.nil?
    @parent = node
    parent.children << self unless node.nil?

    self
  end

  def dfs(target_value)
    return self if self.value == target_value

    self.children.each do |child|
      value = child.dfs(target_value)
      return value unless value.nil?
    end

    nil
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      compare = queue.shift
      if compare.value == target_value
        return compare
      else
        queue += compare.children
      end
    end

    nil
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
    p "recursion set"
    p positions
    positions.each { |pos| neighbors << board[pos] }
    neighbors
  end

end
