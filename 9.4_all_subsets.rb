# ### Problem:
# Write a method to return all subsets of a set.

# ### Clarification:
# What is a set? Definition (Equality of sets): Two sets are equal if and only if they have the same elements. Thus for example {1, 2, 3} = {3, 2, 1}
# The order of elements doesn't matter in a set

# ### Assumptions:
# How many subsets of a set are there? We can compute this by realizing that when we generate a subset, each element has the "choice" of either being in there or not. That is, for the first element, there are two choices: it is either in the set, or it is not. For the second, there are two, etc. So, doing {2 * 2 * ... } n times gives us 2^n subsets. We will therefore not be able to do better than O(2^n) in time or space complexity.
# try to find all subsets of a set, S = {A1, A2, A3,..., An }
# BaseCase: n = 0. There is just one subset of the empty set: {}
# Case: n = 1. There are two subsets of the set {a1}: {},{a1}
# Case: n = 2. There are four subsets of the set {a1,a2}: {},{a1},{a2},{a1,a2}
# Case: n = 3. There are eight subsets of the set {a1,a2,a3}: {},(a1},{a2},{a3},{a1,a2},{a1,a3},{a2,a3},{a1,a2,a3}
# The difference between P(3) and P(2) is missing all the subsets containing a3 # P(3) - P(2) = {a3},{a1,a3},{a2,a3},{a1,a2,a3}
#
# we can create P(3) to using P(2)? We can simply clone the subsets in P(2) and add a3 to them
# P(2) = {},{a1},{a2},{a1,a2}
# P(2) + a3 = {a3},{a1,a3},{a2,a3},{a1,a2,a3}
# P(3) can be derived from merging P(2) and P(2) + a3 

# ### Solutoin:

module MySet
  module_function

  def get_subsets(array)
    raise ArgumentError, "please provide an array of elements for the argument" unless array.is_a?(Array)

    return [[]] if array.empty?
    prev_subsets = get_subsets(array.drop(1))
    new_subsets = []

    prev_subsets.each do |set|
      new_subsets << set + [array.first]
    end
    prev_subsets + new_subsets
  end
end

class ArgumentError < StandardError; end


# ### Sample Output:
MySet.get_subsets([2,3,4,1,5])
# => [[], [5], [1], [5, 1], [4], [5, 4], [1, 4], [5, 1, 4], [3], [5, 3], [1, 3], [5, 1, 3], [4, 3], [5, 4, 3], [1, 4, 3], [5, 1, 4, 3], [2], [5, 2], [1, 2], [5, 1, 2], [4, 2], [5, 4, 2], [1, 4, 2], [5, 1, 4, 2], [3, 2], [5, 3, 2], [1, 3, 2], [5, 1, 3, 2], [4, 3, 2], [5, 4, 3, 2], [1, 4, 3, 2], [5, 1, 4, 3, 2]]


# ### Additional Resources:
# http://stackoverflow.com/questions/20047476/find-all-subsets-in-an-array
# http://stackoverflow.com/questions/34866547/how-can-i-modify-this-recursion-function-to-print-out-letters-in-specific-order
