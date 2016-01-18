# ### Problem:
# Given an MxN matrix in which each row and each column is sorted in ascending order, write a method to find an element.

# ### Clarifications:
# example of ascending order array
# => [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12]]
# we want to find an element in arrays of array.
# do we need to output two numbers? One for the location of the array and second for the location in the array?

# ### Assumptions:
# since it's sorted in ascending order. we can use binary search.

# ### Solution:

module Matrix
  module_function

  def find_element(matrix, element)
    raise ArgumentError.new("Please provide a Matrix (array of arrays)") unless matrix.is_a?(Array)

		row = 0
    col = matrix[0].length - 1 #index of column end

		while row < matrix.length && col >= 0 do
			if matrix[row][col] == element
        puts "element found at [#{row}][#{col}]"
				return true
			elsif matrix[row][col] > element
        col -= 1
			else
        row += 1
      end
    end
    return false
  end
  # TODO additional implementation using binary search 
end

class ArgumentError < StandardError; end


# ### Sample Output:
matrix = [
          [1,2,3,4],
          [5,6,7,8],
          [9,10,11,12],
          [13,14,15,16]
        ]

p Matrix.find_element(matrix, 3)
# => element found at [0][2]
# => true
