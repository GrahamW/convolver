require 'helpers'

describe Convolver do
  describe "#convolve" do

    it "should work like the example in the README" do
      a = NArray[ 0.3, 0.4, 0.5 ]
      b = NArray[ 1.3, -0.5 ]
      c = Convolver.convolve( a, b )
      expect( c ).to be_narray_like NArray[ 0.19, 0.27 ]
    end

    it "should process convolutions of different sizes" do
      [10,50,100].each do |asize|
        [5,25,40].each do |bsize|
          next unless bsize < asize
          a = NArray.sfloat(50,50).random()
          b = NArray.sfloat(10,10).random()
          c = Convolver.convolve( a, b )
          expect( c ).to be_a NArray
        end
      end
    end

    it "should choose #convolve_basic for small inputs" do
      a = NArray.sfloat(50,50).random()
      b = NArray.sfloat(10,10).random()
      Convolver.expects( :convolve_basic ).once
      Convolver.expects( :convolve_fftw3 ).never
      c = Convolver.convolve( a, b )
    end

    it "should choose #convolve_fftw3 for large inputs" do
      a = NArray.sfloat(500,500).random()
      b = NArray.sfloat(100,100).random()
      Convolver.expects( :convolve_basic ).never
      Convolver.expects( :convolve_fftw3 ).once
      c = Convolver.convolve( a, b )
    end

  end

end
