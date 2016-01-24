# ### Problem:
# A magic index in an array A[l...n-l] is defined to be an index such that A[i] = i. Given a sorted array of distinct integers, write a method to find a magic index, if one exists, in array A.
# FOLLOW UP
# What if the values are not distinct?

# ### Clarification:
# Do we want a boolean method that produces true/false if the sorted array contain a magic index?
# Should we assume all arrays would be sorted or should we sort the array just in case?
# Distinct integers meaning all integers are unique correct?
# Is negative integers allowed in the sorted array?
# Are we looking for the existence of a magic index as a subarray in the sorted array?

# ### Assumptions:
# negative numbers
# sorted
# method outputs true/false if sorted array has magic index

# ### Solutoin:

module Magic
  module_function
 
  # O(N)
  def magic_index(array)
    array.select.with_index do |item, index|
      item == index 
    end   
  end

  def magic_index_fast(array, first = 0, last = array.length - 1)
    if first > last || first < 0 || last >= array.length
      return false
    else
      mid_index = (first + last) / 2
    end

    mid_value = array[mid_index]

    if mid_value == mid_index
      true
    elsif mid_index == 0
      false
    # Search left
    elsif mid_value > mid_index 
      left_index = mid_index - 1
      magic_index_fast(array, first, left_index)
    # Search right
    elsif mid_value < mid_index
      right_index = mid_index + 1
      magic_index_fast(array, right_index, last)
    end
  end
end


# ### Sample Output:
a = [-10, -20, 2, 3, 5, 6, 7] #sorted array
Magic.magic_index(a)
# => [2, 3]


# ### Benchmark:
require 'benchmark'

a = (0..600).to_a.sort { rand() - 0.5 }.take(520).sort

Benchmark.bmbm do |x|
  x.report("magic_index:") { Magic.magic_index(a) }
  x.report("magic_index_fast:") { Magic.magic_index_fast(a) }
end

# ### Benchmark results:
# Rehearsal -----------------------------------------------------
# magic_index:        0.000000   0.000000   0.000000 (  0.000076)
# magic_index_fast:   0.000000   0.000000   0.000000 (  0.000009)
# -------------------------------------------- total: 0.000000sec

#                         user     system      total        real
# magic_index:        0.000000   0.000000   0.000000 (  0.000073)
# magic_index_fast:   0.000000   0.000000   0.000000 (  0.000010)
