class Direction

    def initialize(direction:)
        @direction = direction
    end 
    
    def move_forward(x_starting_point)
        return @direction = :N , x_starting_point -= 1
    end 

    def move_backward(x_starting_point)
        return @direction = :S , x_starting_point += 1
    end 

    def move_left(y_starting_point)
        return @direction = :W , y_starting_point -= 1
    end 

    def move_right(y_starting_point)
        return @direction = :E , y_starting_point += 1
    end 

end 