require 'mars_rover'

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

    context 'turn left and right command' do
      context 'passed string to turn the direction to left and right' do
        it 'for facing north direction to west' do
          rover = mars_rover(:N,0,0)
          rover.move('L')
          expect(rover.position).to eq([0,0])
          expect(rover.compass).to eq(:W)
        end 

        it 'for facing north direction to east' do
          rover = mars_rover(:N,0,0)
          rover.move('R')
          expect(rover.position).to eq([0,0])
          expect(rover.compass).to eq(:E)
        end 

        it 'for facing east direction to south' do
          rover = mars_rover(:E,0,0)
          rover.move('R')
          expect(rover.position).to eq([0,0])
          expect(rover.compass).to eq(:S)
        end 
      end 

      context 'passed multiple string to the direction' do
        it 'for facing north direction to north' do
          rover = mars_rover(:N,0,0)
          rover.move('LR')
          expect(rover.position).to eq([0,0])
          expect(rover.compass).to eq(:N)
        end 

        it 'for facing south direction to west' do
          rover = mars_rover(:S,0,0)
          rover.move('LRRLR')
          expect(rover.position).to eq([0,0])
          expect(rover.compass).to eq(:W)
        end 

        it 'for facing east direction to south' do
          rover = mars_rover(:E,0,0)
          rover.move('RRL')
          expect(rover.position).to eq([0,0])
          expect(rover.compass).to eq(:S)
        end 

        it 'for facing west direction to west' do
          rover = mars_rover(:W,0,0)
          rover.move('LRLR')
          expect(rover.position).to eq([0,0])
          expect(rover.compass).to eq(:W)
        end
      end 
    end 

    context 'passed multiple string to move forward' do
      it 'for facing north direction' do
        rover = mars_rover(:N,10,12)
        rover.move('FFFF')
        expect(rover.position).to eq([10,16])
        expect(rover.compass).to eq(:N)
      end 

      it 'for facing east direction' do
        rover = mars_rover(:E,22,22)
        rover.move('BBBBB')
        expect(rover.position).to eq([17,22])
        expect(rover.compass).to eq(:E)
      end 
    end 

    context 'passed multiple string to move forward,backward,right,left' do
      it 'for facing north direction to west' do
        rover = mars_rover(:N,10,12)
        rover.move('flfB')
        expect(rover.position).to eq([10,13])
        expect(rover.compass).to eq(:W)
      end 

      it 'for facing west direction to east' do
        rover = mars_rover(:W,2,2)
        rover.move('FBLRLLFF')
        expect(rover.position).to eq([4,2])
        expect(rover.compass).to eq(:E)
      end 

      it 'for facing east direction to west' do
        rover = mars_rover(:E,22,22)
        rover.move('BLFLLFR')
        expect(rover.position).to eq([21,22])
        expect(rover.compass).to eq(:W)
      end
    end 
end 