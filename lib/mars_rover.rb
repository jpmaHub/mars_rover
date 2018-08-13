class MarsRover
    def initialize(facing_direction: , x: , y:)
      @facing_direction = facing_direction
      @x_coordinate = x
      @y_coordinate = y
      @compass = [:N,:E,:S,:W].freeze
    end 

    def move(commands)
      moves = commands.split(//)   
      moves.each do |move|
        turn(move)
      end 
    end 

    def turn(move)
      case move.upcase
        when 'L'
          return turn_left(@facing_direction)
        when 'R'
          return turn_right(@facing_direction)
        when 'F'
          return turn_forward(@facing_direction)
        when 'B'
          return turn_backward(@facing_direction)
      end 
    end 

    def turn_forward(facing_direction)
      return @y_coordinate += 1 if facing_direction == :N
      return @y_coordinate -= 1 if facing_direction == :S
      return @x_coordinate += 1 if facing_direction == :E
      return @x_coordinate -= 1 if facing_direction == :W
    end

    def turn_backward(facing_direction)
      return @y_coordinate += 1 if facing_direction == :S
      return @y_coordinate -= 1 if facing_direction == :N
      return @x_coordinate += 1 if facing_direction == :W
      return @x_coordinate -= 1 if facing_direction == :E
    end 

    def turn_left(facing_direction)
      return @facing_direction = @compass[find_index(facing_direction) - 1]
    end 

    def turn_right(facing_direction)
      return @facing_direction = @compass.first if @compass[find_index(facing_direction)] == @compass.last
      return @facing_direction = @compass[find_index(facing_direction) + 1]
    end 

    def find_index(facing_direction)
      @compass.find_index(facing_direction)
    end 

    def position
        return '' if coordinates_nil?
        [@x_coordinate, @y_coordinate]
    end 

    def coordinates_nil?
      @x_coordinate.nil? && @y_coordinate.nil?
    end 

    def compass
      return '' if @facing_direction.nil?
      @facing_direction
    end 
end 