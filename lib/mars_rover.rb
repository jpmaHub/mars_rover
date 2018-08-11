class MarsRover
    def initialize(direction: , x: , y:)
      @direction = direction
      @x_coordinate = x
      @y_coordinate = y
      @compass = [:N,:E,:S,:W].freeze
    end 

    def move(moves)
      moves = moves.split(//)   
      moves.each do |move|
        turn(move)
      end 
    end 

    def turn(move)
      case move.upcase
        when 'L'
          return turn_left(@direction)
        when 'R'
          return turn_right(@direction)
        when 'F'
          return turn_forward(@direction)
        when 'B'
          return turn_backward(@direction)
      end 
    end 

    def turn_forward(direction)
      return @y_coordinate += 1 if direction == :N
      return @y_coordinate -= 1 if direction == :S
      return @x_coordinate += 1 if direction == :E
      return @x_coordinate -= 1 if direction == :W
    end

    def turn_backward(direction)
      return @y_coordinate += 1 if direction == :S
      return @y_coordinate -= 1 if direction == :N
      return @x_coordinate += 1 if direction == :W
      return @x_coordinate -= 1 if direction == :E
    end 

    def turn_left(direction)
      return @direction = @compass[find_index(direction) - 1]
    end 

    def turn_right(direction)
      return @direction = @compass.first if @compass[find_index(direction)] == @compass.last
      return @direction = @compass[find_index(direction) + 1]
    end 

    def find_index(direction)
      @compass.find_index(direction)
    end 

    def position
        return '' if @x_coordinate.nil? && @y_coordinate.nil?
        [@x_coordinate, @y_coordinate]
    end 

    def compass
      return '' if @direction.nil?
      @direction
    end 
end 