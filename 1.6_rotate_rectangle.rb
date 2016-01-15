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
    offset = 0

    raise "please provide NxN matrix!" if cols != rows

    while row*2 < rows - 1 do
      # inverse_row = rows - row - 1     # -1 to adjust to referrencing array of arrays

      while col*2 + offset < cols - 1  do # -1 for the repeated corners of swapping the matix
        inverse_row = rows - row - 1     # -1 to adjust to referrencing array of arrays
        inverse_col = cols - col - 1    # -1 to adjust to index col in array

        # tem <- top 
        temp = matrix[row][col + offset]

				# top <- left
				matrix[row][col + offset] = matrix[inverse_row - offset][col]

				# left <- bottom
				matrix[inverse_row - offset][col] = matrix[inverse_row][inverse_col - offset]

				# bottom <- right 
				matrix[inverse_row][inverse_col - offset] = matrix[row + offset][inverse_col]

				# right <- temp 
				matrix[row + offset][inverse_col] = temp 

        offset += 1
          
        #implementation works for 4x4 solution works but not 6x6. TODO implement solution.
      end
      row += 1
      col += 1
      offset = 0
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
matrix_5 = [[1, 2, 3, 4, 5], [6, 7, 8, 9, 10], [11, 12, 13, 14, 15], [16, 17, 18, 19, 20], [21, 22, 23, 24, 25]]
matrix_6 = [[1, 2, 3, 4, 5, 6], [7, 8, 9, 10, 11, 12], [13, 14, 15, 16, 17, 18], [19, 20, 21, 22, 23, 24], [25, 26, 27, 28, 29, 30], [31, 32, 33, 34, 35, 36]]
# Matrix.rotate_inplace(matrix_4)
# => [[13, 9, 5, 1], [14, 10, 6, 2], [15, 11, 7, 3], [16, 12, 8, 4]]
# Matrix.rotate_inplace(matrix_5)
#=> [[5, 10, 15, 20, 25], [4, 9, 14, 19, 24], [3, 8, 13, 18, 23], [2, 7, 12, 17, 22], [1, 6, 11, 16, 21]]
# Matrix.rotate_inplace(matrix_6)
# => [[6, 12, 18, 24, 30, 36], [5, 11, 17, 23, 29, 35], [4, 10, 16, 22, 28, 34], [3, 9, 15, 21, 27, 33], [2, 8, 14, 20, 26, 32], [1, 7, 13, 19, 25, 31]]


# ### Additional Resources:
# http://stackoverflow.com/questions/42519/how-do-you-rotate-a-two-dimensional-array
# http://rubyquiz.strd6.com/quizzes/209-matrix-rotator
# https://www.reddit.com/r/ruby/comments/2jvqjv/ruby_solution_to_cracking_the_coding_interview/

