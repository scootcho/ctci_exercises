require 'rspec'
require '../1.6_rotate_rectangle'


describe "Rotation" do

  context "rotating in place" do

    it "swap matrix 90 degrees" do

      matrix = [
        [1,2,3,4],
        [5,6,7,8],
        [9,10,11,12],
        [13,14,15,16]
      ]


      rotated = [
          [13, 9, 5, 1],
          [14, 10, 6, 2],
          [15, 11, 7, 3],
          [16, 12, 8, 4]
      ]

      expect(Matrix.rotate_inplace(matrix)).to eq(rotated)
    end
  end

  context "rotating with array" do

    it "shall rotate squares" do
      square = [
        [0, 1, 0, 0],
        [0, 1, 1, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 0]
      ]
      
      square_rotated = [
        [0, 0, 0, 0],
        [0, 1, 1, 0],
        [1, 1, 0, 0],
        [0, 0, 0, 0]
      ]
      
      expect(Matrix.rotate(square)).to eq(square_rotated)
    end
    
    it "shall rotate rectangles" do
      rectangle = [
        [0, 1, 0],
        [1, 1, 1]
      ]
      
      rectangle_rotated = [
        [0, 1],
        [1, 1],
        [0, 1]
      ]
      
      expect(Matrix.rotate(rectangle)).to eq(rectangle_rotated)
    end
  end
end

