# frozen_string_literal: true
require 'direction'
class MarsRover
  attr_reader :grid,
              :obstacles

  def initialize(facing_direction:, coordinates:, grid: [100, 100], obstacles: [])
    @facing_direction = facing_direction
    @coordinates = coordinates
    @grid = grid
    @obstacles = obstacles
    @compass = %i[N E S W].freeze
    @dir = Direction.new
  end

  def obstacles_split_into_x_y
    x_coord = []
    y_coord = []
    @obstacles.each do |x, y|
      x_coord.push(x)
      y_coord.push(y)
    end
    [x_coord, y_coord]
  end

  def status
    return :Obstacle if reach_obstacle?
    :OK
  end

  def obstacles_detected
    @coordinates[0] -= 1 if grid_x_coordinate
    @coordinate[1] -= 1 if grid_y_coordinate
    @coordinates
  end

  def move(commands)
    moves = commands.split(//)
    moves.each do |move|
      turn(move) unless reach_obstacle?
      turn(move) if @obstacles.include?([0, 0])
    end
  end

  def turn(move)
    case move.upcase
    when 'L'
      turn_left
    when 'R'
      turn_right
    when 'F'
      @dir.turn_forward(@coordinates, @facing_direction)
    when 'B'
      @dir.turn_backward(@coordinates, @facing_direction)
    end
  end

  def turn_left
    @facing_direction = @compass[index - 1]
  end

  def turn_right
    return @facing_direction = @compass.first if last_element?
    @facing_direction = @compass[index + 1]
  end

  def position
    return '' if @coordinates.nil?
    return grid_passed if reach_grid?
    return obstacles_detected if reach_obstacle?
    @coordinates
  end

  def compass
    return '' if @facing_direction.nil?
    @facing_direction
  end

  def grid_passed
    @coordinates[0] = 0 if grid_x_coordinate
    @coordinates[1] = 0 if grid_y_coordinate
    @coordinates
  end

  def reach_obstacle?
    x_obstacles = obstacles_split_into_x_y[0]
    y_obstacles = obstacles_split_into_x_y[1]
    x_obstacles.include?(@coordinates[0]) && grid_x_coordinate ||
      y_obstacles.include?(@coordinates[1]) && grid_y_coordinate
  end

  def reach_grid?
    @grid[0] == @coordinates[0] || @grid[1] == @coordinates[1]
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
