# frozen_string_literal: true

class MarsRover
  attr_reader :grid,
              :obstacles

  def initialize(facing_direction:, x:, y:, grid: [100, 100], obstacles: [])
    @facing_direction = facing_direction
    @x_coordinate = x
    @y_coordinate = y
    @grid = grid
    @obstacles = obstacles
    @compass = %i[N E S W].freeze
  end

  def find_x_obstacles
    x_coord = []
      @obstacles.each do |x, _y|
        x_coord.push(x)
      end
    x_coord
  end

  def find_y_obstacles
    y_coord = []
    @obstacles.each do |_x, y|
      y_coord.push(y)
    end
    y_coord
  end

  def status
    return :Obstacle if reach_obstacle?
    :OK
  end

  def obstacles_detected
    @x_coordinate -= 1 if grid_x_coordinate
    @y_coordinate -= 1 if grid_y_coordinate
    [@x_coordinate, @y_coordinate]
  end

  def move(commands)
    moves = commands.split(//)
    moves.each do |move|
      turn(move) unless reach_obstacle?
      turn(move) if @obstacles.include?([0,0])
    end
  end

  def turn(move)
    case move.upcase
    when 'L'
      turn_left
    when 'R'
      turn_right
    when 'F'
      turn_forward
    when 'B'
      turn_backward
    end
  end

  def turn_forward
    return @y_coordinate += 1 if @facing_direction == :N
    return @y_coordinate -= 1 if @facing_direction == :S
    return @x_coordinate += 1 if @facing_direction == :E
    return @x_coordinate -= 1 if @facing_direction == :W
  end

  def turn_backward
    return @y_coordinate += 1 if @facing_direction == :S
    return @y_coordinate -= 1 if @facing_direction == :N
    return @x_coordinate += 1 if @facing_direction == :W
    return @x_coordinate -= 1 if @facing_direction == :E
  end

  def turn_left
    @facing_direction = @compass[index - 1]
  end

  def turn_right
    return @facing_direction = @compass.first if last_element?
    @facing_direction = @compass[index + 1]
  end

  def position
    return '' if coordinates_nil?
    return grid_passed if reach_grid?
    return obstacles_detected if reach_obstacle?
    [@x_coordinate, @y_coordinate]
  end

  def compass
    return '' if @facing_direction.nil?
    @facing_direction
  end

  def grid_passed
    @x_coordinate = 0 if grid_x_coordinate
    @y_coordinate = 0 if grid_y_coordinate
    [@x_coordinate, @y_coordinate]
  end

  def reach_obstacle?
    x_coord = find_x_obstacles
    y_coord = find_y_obstacles
    x_coord.include?(@x_coordinate) && grid_x_coordinate || y_coord.include?(@y_coordinate) && grid_y_coordinate
  end

  def reach_grid?
    @grid[0] == @x_coordinate || @grid[1] == @y_coordinate
  end

  def coordinates_nil?
    @x_coordinate.nil? && @y_coordinate.nil?
  end

  def last_element?
    @compass[index] == @compass.last
  end

  def index
    @compass.find_index(@facing_direction)
  end

  def grid_x_coordinate
    @facing_direction == :E || @facing_direction == :W
  end

  def grid_y_coordinate
    @facing_direction == :S || @facing_direction == :N
  end
end
