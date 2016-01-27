# ### Problem:
# Given a sorted array of n integers that has been rotated an unknown number of times, write code to find an element in the array. You may assume that the array was originally sorted in increasing order.
# EXAMPLE
# Input:find 5 in {15, 16, 19, 20, 25, 1, 3, 4, 5, 7, 10, 14} Output: 8 (the index of 5 in the array)

# ### Clarifications:
# Are we creating a method that will output the index of the provided number in an Array?
# Are there repeated numbers? If so do we want the index of the first match it finds? Or do we output of all locations of the same number?

# ### Assumptions:
# No repeated numbers
# Do not use built in Array#find method

# ### Solution:

def find_in_array(array, num)
  array.each.with_index do |element, index|
    if element == num
      puts index
    end
  end
end


# ### Sample Output:
array = [3, 9, 10, 0, 8, 5, 1, 2, 4, 6, 7]
p find_in_array(array, 2)
# => 7
