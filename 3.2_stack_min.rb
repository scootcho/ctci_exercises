# #### Problem:
# How would you design a stack which, in addition to push and pop, also has a function min which returns the minimum element? Push, pop and min should all operate in O(1) time.

# ### Clarification:
# We need to design a function called min that will returns the minimum element in the stack in any given time it was called?

# ### Assumption:
# we must satisfy the O(1) time criteria while keeping space optimization in mind.

# ### Design an Alogrithm:
# If we kept track of the minimum at each state, we would be able to easily know the minimum. We can do this by having each node record what the minimum beneath itself is. Then, to find the min, you just look at what the top element thinks is the min. There is a problem though, we can guaranteed the O(1) time but we will waste a lot of space O(n) as the stack grows larger.
# 
# Extra stack to track min in a stack.
# * To retrieve the current minimum, just return the top element from minimum stack.
# * Each time you perform a push operation, check if the pushed element is a new minimum. If it is, push it to the minimum stack too.
# * When you perform a pop operation, check if the popped element is the same as the current minimum. If it is, pop it off the minimum stack too.
# * All of the above operates in O(1) constant time.

# ### Solution:

require_relative './lib/stack'

class StackWithMin < Stack

  def initialize(data=nil)
    super(data)
    @min_stack = Stack.new(data)
  end

  def push(data)
    super(data)
    if @min_stack.data == nil
      @min_stack.push(data)
    else
      @min_stack.push(data) if data < @min_stack.peek
    end
  end

  def pop
    super
    @min_stack.pop if @top.data == @min_stack.peek
  end

  def min
    @min_stack.peek
  end

end

# ### Sample Output:

minstack = StackWithMin.new
minstack.push(4)
p minstack.min
# => 4
minstack.push(3)
p minstack.min
# => 3
minstack.push(2)
p minstack.min
# => 2
p minstack.pop
p minstack
p minstack.min

# Additional Resources
# http://www.geeksforgeeks.org/design-and-implement-special-stack-data-structure/
# http://articles.leetcode.com/2010/11/stack-that-supports-push-pop-and-getmin.html
# http://www.careercup.com/question?id=14462745
