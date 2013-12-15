$: << Dir.pwd
require 'processor'

describe Processor do
  before do
    @hash = { [1,1] => 1, [3,2] => 1, [2,3] => 1 }
  end

  describe 'calculate neighbours' do
    before do
      @processor = Processor.new(@hash)
    end

    it 'should eq 3' do
      expect(@processor.neigh_count([2,2])).to eq(3)
    end

    it 'should eq 1' do
      expect(@processor.neigh_count([1,3])).to eq(1)
    end

    it 'should eq 2' do
      expect(@processor.neigh_count([2,1])).to eq(2)
    end

    describe 'special case' do
      before do
        @hash = { [1,1] => 1, [3,2] => 1, [2,3] => 1, [2,2] => 1 }
        @processor = Processor.new(@hash)
      end

      it 'should eq 3' do
        expect(@processor.neigh_count([2,2])).to eq(3)
      end
    end
  end

  describe 'alive?' do
    before do
      @hash = { [1,1] => 1, [3,2] => 1, [2,3] => 1, [3,1] => 1 }
      @processor = Processor.new(@hash)
    end

    it 'should die' do
      expect(@processor.alive?([2,2])).to be_false
    end

    it 'should die' do
      expect(@processor.alive?([1,1])).to be_false
    end

    it 'should live' do
      expect(@processor.alive?([2,1])).to be_true
    end

    it 'should live' do
      expect(@processor.alive?([3,2])).to be_true
    end
  end

  describe 'process_cell' do
    before do
      @processor = Processor.new(@hash)
    end

    it 'should call alive? 9 times' do
      @processor.should_receive(:alive?).exactly(9).times
      @processor.process_cell([2,2])
    end

    it 'should set 1' do
      @processor.process_cell([2,2])
      new_hash = @processor.instance_variable_get('@new_hash')
      expect(new_hash[[2,2]]).to eq(1)
    end

  end

  describe 'integration test' do
    before do
      @hash0 = { [2,1] => 1, [2,2] => 1, [2,3] => 1}
      @hash1 = { [1,2] => 1, [2,2] => 1, [3,2] => 1}
      @processor = Processor.new(@hash0)
    end

    it 'should next_gen!' do
      expect(@processor.next_gen!).to eq(@hash1)
    end
  end
end
