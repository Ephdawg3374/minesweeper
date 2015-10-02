require 'byebug'
require_relative 'game'
require_relative 'tilenode'
require_relative 'board'

if __FILE__ == $PROGRAM_NAME
  a = Board.new
  a.render
end
