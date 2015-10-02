require 'byebug'
require_relative 'game'
require_relative 'tilenode'
require_relative 'board'

if __FILE__ == $PROGRAM_NAME
  a = Game.new
  a.board.render
  #adjacent = a.board[[0,0]].adjacent_tiles(a.board)
  #adjacent.each { |x| print "#{x.position}\n"}
  p a.reveal([0,0])
  a.board.render
end
