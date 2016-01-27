# ### Problem:
# Imagine a (literal) stack of plates. If the stack gets too high, it migh topple. Therefore, in real life, we would likely start a new stack when the previous stack exceeds some threshold. Implement a data structure SetOfStacks that mimics this. SetOfStacks should be composed of several stacks and should create a new stack once the previous one exceeds capacity. SetOfStacks.push() and SetOfStacks.pop() should behave identically to a single stack (that is, pop() should return the same values as it would if there were just a single stack).
# FOLLOW UP
# Implement a function popAt(int index) which performs apop operation ona specific sub-stack.

# ### Clarification:
# Is there a minimum numbers of stacks we're initializing?
# What about the capacity of the stack? Are we allowing the size of the stack to be passed in or are we hardcoding the stack size?

# ### Design Algorithm:
# SetOfStack class has both push() and pop() functions that behaves just like the Stack class.
# However, we need to create a new stack when a stack reach its capacity and removes a stack if it is empty
# We can either use a varaible to track how many stacks are being created. or we can just use the index number to keep track of the stacks since we're keeping the stacks in an array.
# We can also implement error checker that will throw error when the capacity was exceeded
#
# popAt(int index)
# If we pop an element from stack 1, we need to remove the bottom of stack 2 and push it onto stack 1. We then need to rollover from stack 3 to stack 2, stack 4 to stack 3, etc.
# You could make an argument that, rather than "rolling over," we should be OK with some stacks not being at full capacity. This would improve the time complexity

# ### Solution:
# TODO comeback to refactor 

require_relative './lib/stack'

class SetOfStacks < Stack
  attr_accessor :array

  def initialize(data, stack_capacity = 10)
    @array = []
    @stack_size = 0
    @stack_capacity = stack_capacity
    @stack = Stack.new(data)
    @stack_size += 1
    @array << @stack
  end

  def push(data)
    if @stack_size == @stack_capacity
      @stack = Stack.new(data)
      @array << @stack
      @stack_size = 1
    else
      @stack = @array[-1]
      new = Element.new(data)
      new.next = @stack.top
      @stack.top = new
      @stack_size += 1
    end
  end

  def pop
    if @stack_size == 1
      self.array.pop #this also removes the last element in the last stack, so the @stack.top = @stack.top.next is not needed 
      @stack = @array[-1]
      raise OperationError.new("The stack is empty!") if self.array.length == 0 && @stack.top == nil
      @stack_size = @stack_capacity
    else
      @stack = @array[-1]
      raise OperationError.new("The stack is empty!") if self.array.length == 0 && @stack.top == nil
      @stack.top = @stack.top.next
      @stack_size -= 1
    end
  end

  def peek
    @stack = @array[-1]
    raise OperationError.new("The stack is empty!") if @stack.top == nil
    return @stack.top.data
  end

  def current_stack
    self.array[-1]
  end

  def stacks_number
    self.array.length
  end

  def is_full?
    @stack_size == @stack_capacity ? true : false
  end

end

class OperationError < StandardError; end


# ### Sample Output:
stack = SetOfStacks.new(1, 3)
stack.push(2)
stack.push(3)
stack.push(4)
stack.push(5)
p stack
