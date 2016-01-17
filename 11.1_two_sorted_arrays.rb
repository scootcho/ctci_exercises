# ### Problem:
# You are given two sorted arrays, A and B, where A has a large enough buffer at the end to hold B. Write a method to merge B into A in sorted order

# ### Clarifications:
# are we creating a method that takes two sorted arrays and oupt a sorted array of the two arrays combined?
# are each element in arrays uniq?
# what if happens when there are two identical elements in both array? Are we keeping both or remove duplicates? 

# ### Assumptions:
# produce a large array combining two sorted arrays
# keeps duplicates
# Our logic should involve simply comparing elements of A and B and inserting them in order, until we've exhausted all elements in A and in B
# The only issue with this is that if we insert an element into the front of A, then we'll have to shift the existing elements backwards to make room for it. It's better to insert elements into the back of the array, where there's empty space.

# ### Solution:

def combine_arrays(array_a, array_b)
  index_a = array_a.length - 1
  index_b = array_b.length - 1
  index_merged = array_a.length + array_b.length - 1

  while index_b >= 0 do
    if array_a[index_a] > array_b[index_b] && index_a >= 0
      array_a[index_merged] = array_a[index_a] #since the problem mention array A has the space capacity. We're inserting into array A
      index_a -= 1
      index_merged -= 1
    else 
      array_a[index_merged] = array_b[index_b]
      index_b -= 1
      index_merged -= 1
    end
  end
  return array_a
end

# ### Sample Output:
a1 = (1..10).to_a
a2 = (11..20).to_a
p combine_arrays(a1, a2)
# => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
