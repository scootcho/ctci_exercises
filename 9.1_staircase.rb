# ### Problem:
# A child is running up a staircase with n steps, and can hop either 1 step, 2 steps, or 3 steps at a time. Implement a method to count how many possible ways the child can run up the stairs.

# ### Clarification:
# we're creating a method that takes a number which is the total number of stairs and outputs numbers of ways to climb to the stairs given we have the choice to hop 1,2,3 steps?

# ### Solutoin:
# On the very last hop, up to the nth step, the child could have done either a single, double, or triple step hop.
# That is,the last move might have been a single step hop from step n-1, a double step hop from step n-2, or a triple step hop from n-3.
# The total number of ways of reaching the last step is therefore the sum of the number of ways of reaching each of the last three steps

# recursive method O(3^n)
# this algorithm is exponential since each call branches out to three more calls.
def count_ways(n)
  if n < 0  #base case when last staircase cannot be reached
    return 0
  elsif n == 0 #last staircase reached, return 1 to count one possible way
    return 1
  else
    return count_ways(n - 1) + count_ways(n - 2) + count_ways(n - 3)
  end
end

# dynamic method O(n^3)
def count_ways_dp(n, cache = {})
  if n < 0
    return 0
  elsif n == 0
    return 1
  else
    return cache[n] ||= count_ways_dp(n - 1, cache) + count_ways_dp(n - 2, cache) + count_ways_dp(n - 3, cache)
  end
end

# ### Sample Output:

p count_ways(4)
# => 7
p count_ways(5)
# => 13


# ### Benchmarks:
require 'benchmark'

n = 25 #above 25 takes too long and possible stack too deep

Benchmark.bmbm do |x|
  x.report("recursive:") { count_ways(n) }
  x.report("dynamic programming:") { count_ways_dp(n) }
end

# ### Benchmarks results:
# Rehearsal --------------------------------------------------------
# recursive:             0.870000   0.000000   0.870000 (  0.870701)
# dynamic programming:   0.000000   0.000000   0.000000 (  0.000051)
# ----------------------------------------------- total: 0.870000sec

#                            user     system      total        real
# recursive:             0.860000   0.000000   0.860000 (  0.869072)
# dynamic programming:   0.000000   0.000000   0.000000 (  0.000039)






# >> 7
# >> 13
# >> Rehearsal --------------------------------------------------------
# >> recursive:             0.740000   0.000000   0.740000 (  0.741689)
# >> dynamic programming:   0.000000   0.000000   0.000000 (  0.000027)
# >> ----------------------------------------------- total: 0.740000sec
# >> 
# >>                            user     system      total        real
# >> recursive:             0.730000   0.000000   0.730000 (  0.730785)
# >> dynamic programming:   0.000000   0.000000   0.000000 (  0.000032)
