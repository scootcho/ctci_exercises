# ### Problem:
# Describe how you could use a single array to implement three stacks.

# ### Clarification:
# How are these stacks going to be used? are they going to be used somewhat equally or will one/more stack be used significantly more than others?
# Is the array fixed lengths? 

# ### Assumptions:

# ### Design Algorithm:
# Approach 1: Fixed Division
# divide array into 3 equal parts and allow the individual stack to grow in that limited space.
# * Forstack 1, we will use [0, n/3).
# * For stack2,wewill use[n/3j 2n/3).
# * For stacks, wewill use [2n/3, n).
# 
# Approach 2: Flexible Divisions
# allow the stack size to be flexible, we allocate more space to it. we design array to be circular, so the last stack starts at the end of the array and wrap around to the beginning. 
# we have a StackData class that tracks the capacity, size, and pointer of stacks.

# ### Solution:
# TODO implement solution
