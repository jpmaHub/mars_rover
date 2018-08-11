require 'mars_rover'
require 'direction'

def mars_rover(direction , x_coord , y_coord)
  MarsRover.new(direction: direction, x: x_coord , y:y_coord)
end 

describe MarsRover do

   it 'returns empty string when nils passed' do
    rover = mars_rover(nil,nil,nil)
    expect(rover.position).to eq('')
    expect(rover.compass).to eq('')
   end 

   it 'returns (direction :N , x: 0 , x:0) when arguments passed' do
    rover = mars_rover(:N,0,0)
    expect(rover.position).to eq([0,0])
    expect(rover.compass).to eq(:N)
    end 

    context 'passed string to turn the direction to left' do
      it 'for facing north direction to west' do
        rover = mars_rover(:N,0,0)
        rover.move('L')
        expect(rover.compass).to eq(:W)
      end 

      it 'for facing west direction to south' do
        rover = mars_rover(:W,0,0)
        rover.move('L')
        expect(rover.compass).to eq(:S)
      end 

      it 'for facing south direction to east' do
        rover = mars_rover(:S,0,0)
        rover.move('L')
        expect(rover.compass).to eq(:E)
      end 

      it 'for facing east direction to north' do
        rover = mars_rover(:E,0,0)
        rover.move('L')
        expect(rover.compass).to eq(:N)
      end 
    end 

    context 'passed string to turn the direction to right' do
      it 'for facing north direction to east' do
        rover = mars_rover(:N,0,0)
        rover.move('R')
        expect(rover.compass).to eq(:E)
      end 

      it 'for facing east direction to south' do
        rover = mars_rover(:E,0,0)
        rover.move('R')
        expect(rover.compass).to eq(:S)
      end 

      it 'for facing south direction to west' do
        rover = mars_rover(:S,0,0)
        rover.move('R')
        expect(rover.compass).to eq(:W)
      end 

      it 'for facing west direction to north' do
        rover = mars_rover(:W,0,0)
        rover.move('R')
        expect(rover.compass).to eq(:N)
      end 
    end 

    context 'passed multiple string to the direction' do
      it 'for facing north direction to north' do
        rover = mars_rover(:N,0,0)
        rover.move('LR')
        expect(rover.compass).to eq(:N)
      end 

      it 'for facing north direction to north' do
        rover = mars_rover(:S,0,0)
        rover.move('LRRLR')
        expect(rover.compass).to eq(:W)
      end 
    end 
end 