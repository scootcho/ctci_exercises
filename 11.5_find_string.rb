# ### Problem:
# Given a sorted array of strings which is interspersed with empty strings, write a method to find the location of a given string.
# EXAMPLE
# Input: find "ball" in {"at", "", "", "", "ball", "", "", "car", "", "", "dad", "", ""}
# Output: 4

# ### Clarifications:
# we're given a sorted array with strings as elements and the method will output the index location of the found string?

# ### Assumptions:

# ### Solution:

# The method can be written with ease with each_with_index. Reason for using pointer is for exercise.
module Finder
  module_function

  def locate_string(array, string)
    pointer = 0
    while pointer < array.length do
      if array[pointer] != string
        pointer += 1
      else array[pointer] == string
        return pointer
      end
    end
    return "no string found in array"
  end
end

# ### Sample Output:
array = ["at", "", "", "", "ball", "", "", "car", "", "", "dad", "", ""]

p Finder.locate_string(array, "ball")
# => 4
p Finder.locate_string(array, "balls")
# => "no string found in array"
