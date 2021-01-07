# input = "L.LL.LL.LL
# LLLLLLL.LL
# L.L.L..L..
# LLLL.LL.LL
# L.LL.LL.LL
# L.LLLLL.LL
# ..L.L.....
# LLLLLLLLLL
# L.LLLLLL.L
# L.LLLLL.LL".lines.map(&:strip).map(&:chars)

require 'pry'


class Grid
  attr_accessor :grid

  def initialize(grid)
    @grid = grid
  end

  def neighbours(i, j)
    indexes = [i - 1, i, i + 1].product([j - 1, j, j + 1]) - [[i, j]]
    indexes = indexes.select { |x, y| x >= 0 && x < grid.length && y >= 0 && y < grid.first.length }
    indexes.map { |x, y| grid[x][y] }
  end

  def occupied_count(i, j)
    occupied_count = neighbours(i, j).count('#')
  end

  def transform
    Grid.new(
      grid.map.with_index do |row, i|
        row.map.with_index do |cell, j|
          occupied_count = occupied_count(i, j)

          case cell
          when '.' then '.'
          when '#' then occupied_count >= 4 ? 'L' : '#'
          when 'L' then occupied_count == 0 ? '#' : 'L'
          end
        end
      end
    )
  end

  def ==(g)
    g.class == self.class && g.grid == self.grid
  end

  def self.steady_state_oc(input)
    g = Grid.new(input)
    g2 = g.transform

    g, g2 = g2, g2.transform until g2 == g
    g.grid.flatten.count('#')
  end
end

input = File.readlines("#{__dir__}/../files/11.input").map(&:chars)

puts '='*20
puts 'part 1'
puts Grid.steady_state_oc(input)

puts '='*20
puts 'part 2'
