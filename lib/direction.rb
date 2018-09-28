class Direction
  def turn_forward(coordinates , facing_direction)
    return  coordinates[1] += 1 if facing_direction == :N
    return  coordinates[1] -= 1 if facing_direction == :S
    return  coordinates[0] += 1 if facing_direction == :E
    return  coordinates[0] -= 1 if facing_direction == :W
  end

  def turn_backward(coordinates , facing_direction)
    return coordinates[1] += 1 if facing_direction == :S
    return coordinates[1] -= 1 if facing_direction == :N
    return coordinates[0] += 1 if facing_direction == :W
    return coordinates[0] -= 1 if facing_direction == :E
  end
end 