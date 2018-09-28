# frozen_string_literal: true

require 'mars_rover'

def mars_rover(direction, coordinates)
  MarsRover.new(facing_direction: direction, coordinates: coordinates)
end

def mars_rover_with_grid(direction, coordinates, grid)
  MarsRover.new(facing_direction: direction, coordinates: coordinates, grid: grid)
end

def mars_rover_with_obstacles(direction, coordinates, obstacles)
  MarsRover.new(facing_direction: direction, coordinates: coordinates, obstacles: obstacles)
end

describe MarsRover do
  it 'returns empty string when nils passed' do
    rover = mars_rover(nil, [nil])
    expect(rover.position).to eq('')
    expect(rover.compass).to eq('')
  end

  it 'returns (direction :N , x: 0 , x:0) when arguments passed' do
    rover = mars_rover(:N, [0, 0])
    expect(rover.position).to eq([0, 0])
    expect(rover.compass).to eq(:N)
  end

  context 'turn left and right command' do
    context 'passed string to turn the direction to left and right' do
      it 'for facing north direction to west' do
        rover = mars_rover(:N, [0, 0])
        rover.move('L')
        expect(rover.position).to eq([0, 0])
        expect(rover.compass).to eq(:W)
      end

      it 'for facing north direction to east' do
        rover = mars_rover(:N,[0, 0])
        rover.move('R')
        expect(rover.position).to eq([0, 0])
        expect(rover.compass).to eq(:E)
      end

      it 'for facing east direction to south' do
        rover = mars_rover(:E,[0, 0])
        rover.move('R')
        expect(rover.position).to eq([0, 0])
        expect(rover.compass).to eq(:S)
      end
    end

    context 'passed multiple string to the direction' do
      it 'for facing north direction to north' do
        rover = mars_rover(:N, [0, 0])
        rover.move('LR')
        expect(rover.position).to eq([0, 0])
        expect(rover.compass).to eq(:N)
      end

      it 'for facing south direction to west' do
        rover = mars_rover(:S, [0, 0])
        rover.move('LRRLR')
        expect(rover.position).to eq([0, 0])
        expect(rover.compass).to eq(:W)
      end

      it 'for facing east direction to south' do
        rover = mars_rover(:E, [0, 0])
        rover.move('RRL')
        expect(rover.position).to eq([0, 0])
        expect(rover.compass).to eq(:S)
      end

      it 'for facing west direction to west' do
        rover = mars_rover(:W, [0, 0])
        rover.move('LRLR')
        expect(rover.position).to eq([0, 0])
        expect(rover.compass).to eq(:W)
      end
    end
  end

  context 'passed multiple string to move forward' do
    it 'for facing north direction' do
      rover = mars_rover(:N, [10, 12])
      rover.move('FFFF')
      expect(rover.position).to eq([10, 16])
      expect(rover.compass).to eq(:N)
    end

    it 'for facing east direction' do
      rover = mars_rover(:E, [22, 22])
      rover.move('BBBBB')
      expect(rover.position).to eq([17, 22])
      expect(rover.compass).to eq(:E)
    end
  end

  context 'passed multiple string to move forward,backward,right,left' do
    it 'for facing north direction to west' do
      rover = mars_rover(:N, [10, 12])
      rover.move('flfB')
      expect(rover.position).to eq([10, 13])
      expect(rover.compass).to eq(:W)
    end

    it 'for facing west direction to east' do
      rover = mars_rover(:W,[ 2, 2])
      rover.move('FBLRLLFF')
      expect(rover.position).to eq([4, 2])
      expect(rover.compass).to eq(:E)
    end

    it 'for facing east direction to west' do
      rover = mars_rover(:E, [22, 22])
      rover.move('BLFLLFR')
      expect(rover.position).to eq([21, 22])
      expect(rover.compass).to eq(:W)
    end
  end

  context 'when grid passed' do
    it 'can assign grid size' do
      rover = mars_rover_with_grid(:N, [10, 12], [12, 12])
      expect(rover.grid).to eq([12, 12])
    end

    it 'can use default value 100x100 when grid is not assigned' do
      rover = mars_rover(:N,[ 10, 12])
      expect(rover.grid).to eq([100, 100])
    end

    context 'passed string to move forward' do
      it 'can return X to 0 when grid is passed' do
        rover = mars_rover_with_grid(:E, [9, 9], [10, 10])
        rover.move('F')
        expect(rover.position).to eq([0, 9])
      end

      it 'can return X to 0 when grid is passed for east' do
        rover = mars_rover_with_grid(:E, [9, 9], [11, 10])
        rover.move('F')
        expect(rover.position).to eq([10, 9])
      end

      it 'can return X to 0 when grid is passed for west' do
        rover = mars_rover_with_grid(:W, [9, 9], [8, 10])
        rover.move('F')
        expect(rover.position).to eq([0, 9])
      end

      it 'can return Y to 0 when grid is passed for south' do
        rover = mars_rover_with_grid(:S, [9, 9], [10, 8])
        rover.move('F')
        expect(rover.position).to eq([9, 0])
      end

      it 'can return Y to 0 when grid is passed for north' do
        rover = mars_rover_with_grid(:N, [9, 9], [10, 10])
        rover.move('F')
        expect(rover.position).to eq([9, 0])
      end
    end

    context 'passed multiple string to move backward' do
      it 'can return X to 0 when grid is passed' do
        rover = mars_rover_with_grid(:W, [9, 9], [10, 10])
        rover.move('B')
        expect(rover.position).to eq([0, 9])
      end

      it 'can return X to 0 when grid is passed for west' do
        rover = mars_rover_with_grid(:E, [9, 9], [8, 10])
        rover.move('B')
        expect(rover.position).to eq([0, 9])
      end

      it 'can return Y to 0 when grid is passed for south' do
        rover = mars_rover_with_grid(:N, [9, 9], [10, 8])
        rover.move('B')
        expect(rover.position).to eq([9, 0])
      end

      it 'can return Y to 0 when grid is passed for north' do
        rover = mars_rover_with_grid(:S, [9, 9], [10, 10])
        rover.move('B')
        expect(rover.position).to eq([9, 0])
      end

      it 'can return Y to 0 when grid is passed for north' do
        rover = mars_rover_with_grid(:S,[9, 8], [10, 10])
        rover.move('BBFB')
        expect(rover.position).to eq([9, 0])
      end
    end
  end

  context 'obstacle detection' do
    it 'can assign obstacles' do
      rover = mars_rover_with_obstacles(:N, [10, 12], [[5, 5], [3, 7]])
      expect(rover.obstacles).to eq([[5, 5], [3, 7]])
    end

    it 'can assign obstacles' do
      rover = mars_rover(:N, [10, 12])
      expect(rover.obstacles.length).to eq(0)
    end

    it 'can not move to the obstacle' do
      rover = mars_rover_with_obstacles(:E, [0, 0], [[5, 1], [3, 0]])
      rover.move('fff')
      expect(rover.position).to eq([2, 0])
    end

    it 'can not move to the obstacle' do
      rover = mars_rover_with_obstacles(:E, [0, 0], [[3, 0]])
      rover.move('ffflf')
      expect(rover.position).to eq([2, 0])
    end

    it 'can not move to the obstacle' do
      rover = mars_rover_with_obstacles(:E, [0, 0], [[3, 0], [5, 2], [0, 0]])
      rover.move('ffflf')
      expect(rover.position).to eq([2, 0])
    end

    it 'can set status when obstacle is detected' do
      rover = mars_rover_with_obstacles(:E,[0, 0], [[1, 0]])
      rover.move('f')
      expect(rover.status).to eq(:Obstacle)
    end

    it 'can set status when obstacle is not detected' do
      rover = mars_rover(:E,[0,0])
      rover.move('f')
      expect(rover.status).to eq(:OK)
    end
  end
end
