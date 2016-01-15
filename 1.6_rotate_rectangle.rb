# ### Problem:
# Given an image represented by an NxN matrix, where each pixel in the image is 4 bytes, write a method to rotate the image by 90 degrees. Can you do this in place?

# ### Clarifications:
# what does rotate in place mean?
# 90 degrees clock or counterclock rotate?

# ### Assumptions:
# in-place meaning not creating new arrays but to swap values around instead.
# NxN equal sided matrix.
#
# input = [
#           [1,2,3,4],
#           [5,6,7,8],
#           [9,10,11,12],
#           [13,14,15,16]
#          ]
#          
# output = [
#           [13, 9, 5, 1],
#           [14, 10, 6, 2],
#           [15, 11, 7, 3],
#           [16, 12, 8, 4
#          ]

# ### Solution:
# multi-dimensional array quick hand
# empty_table = Array.new(3) { Array.new(3) }
# => [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]

module Matrix
  module_function

  def rotate_inplace(matrix)
    # the term layer is appropriate as you're changing two numbers at once by rotating hence total layers are rows / 2; 8 rows will be rotated 4 times.
    rows = matrix.count
    cols = matrix[0].length
    row = 0
    col = 0
    pointer = 0

    raise "please provide NxN matrix!" if cols != rows

    while row*2 < rows do
      inverse_row = rows - row - 1     # -1 to adjust to referrencing array of arrays
      inverse_col = cols - col - 1     # -1 to adjust to index col in array

      while pointer < inverse_col do

        p "row: #{row}"
        p "inverse_row: #{inverse_row}"
        p "col: #{col}"
        p "inverse_col: #{inverse_col}"
        p "pointer: #{pointer}"

        # tem <- top 
        temp = matrix[row][col + pointer]

				# top <- left
        matrix[row][col + pointer] = matrix[inverse_row - pointer][col]

				# left <- bottom
        matrix[inverse_row - pointer][col] = matrix[inverse_row][inverse_col - pointer]

				# bottom <- right 
        matrix[inverse_row][inverse_col - pointer] = matrix[row + pointer][inverse_col]

				# right <- temp 
        matrix[row + pointer][inverse_col] = temp 

        pointer += 1
          
        p "********** inner ***********"
      end
        p "********** outter ***********"
      row += 1
      col += 1
      pointer = col
    end
    p matrix
  end

  # using new arrays for matrix
  def rotate(matrix) 
    rows, cols = matrix.size, matrix[0].size
    Array.new(cols) {|i| Array.new(rows) {|j| matrix[j][cols - i - 1]}}
  end
end

# This algorithm is O(N2), which is the best we can do since any algorithm must touch all N2 elements.

# ### Sample Ouput:
# (1..16).to_a.each_slice(4).to_a
matrix_4 = [[1,2,3,4], [5,6,7,8], [9,10,11,12], [13,14,15,16]]
p Matrix.rotate_inplace(matrix_4)
# => [[13, 9, 5, 1], [14, 10, 6, 2], [15, 11, 7, 3], [16, 12, 8, 4]]
matrix_5 = [[1, 2, 3, 4, 5], [6, 7, 8, 9, 10], [11, 12, 13, 14, 15], [16, 17, 18, 19, 20], [21, 22, 23, 24, 25]]
p Matrix.rotate_inplace(matrix_5)
# => [[21, 16, 11, 6, 1], [22, 17, 12, 7, 2], [23, 18, 13, 8, 3], [24, 19, 14, 9, 4], [25, 20, 15, 10, 5]]
matrix_6 = [[1, 2, 3, 4, 5, 6], [7, 8, 9, 10, 11, 12], [13, 14, 15, 16, 17, 18], [19, 20, 21, 22, 23, 24], [25, 26, 27, 28, 29, 30], [31, 32, 33, 34, 35, 36]]
p Matrix.rotate_inplace(matrix_6)
# => [[31, 25, 19, 13, 7, 1], [32, 26, 28, 14, 8, 2], [33, 27, 15, 16, 20, 3], [34, 17, 21, 22, 10, 4], [35, 29, 23, 9, 11, 5], [36, 30, 24, 18, 12, 6]]


# ### Additional Resources:
# http://stackoverflow.com/questions/42519/how-do-you-rotate-a-two-dimensional-array
# http://rubyquiz.strd6.com/quizzes/209-matrix-rotator
# https://www.reddit.com/r/ruby/comments/2jvqjv/ruby_solution_to_cracking_the_coding_interview/

