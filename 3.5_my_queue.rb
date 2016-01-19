# ### Problem:
# Implement a MyQueue class which implements a queue using two stacks.

# ### Clarification:
# Queue is FIFO. oldest goes first

# ### Solution:
# stack all elements in stack_newest. The newest elements will be on top of the stack.
# when there is a dequeque or peek on the que, pop everything from stack_newest onto stack_oldest. 
# oldest elements will be on top of stack_oldest. We can perform peek or pop as dequeue on stack_oldest.
# If each time the peek and pop operations performed the elements are push from stack_oldest back to stack_newest, we're needlessly moving elements.
# keep the elements on stack_oldest after pushed from stack_newest. Push all elements from stack_newest to stack_oldest once stack_oldest is empty.
# In this approach, stack_newest has the newest elements on top and stack_oldest has the oldest elements on top.
 
require_relative './lib/stack'

class MyCue
  attr_reader :stack_newest, :stack_oldest

  def initialize(data=nil)
    @stack_newest = Stack.new
    @stack_oldest = Stack.new(data)
  end

  def enqueue(value)
    # push onto stack_newest
		@stack_newest.push(value)
  end

  # Move elements from stack_newest into stack_oldest in order to perform operations on stack_oldest.
  # we only need to move elements from stack_newest to stack_oldes once stack_oldest is empty and there is a dequeque or peek operation
	def shift_stacks
    if @stack_oldest.top.data == nil
      while @stack_newest.top.data != nil
        value = @stack_newest.pop.data
        @stack_oldest.push(value) if value != nil
      end
    end
  end
	
	def peek
		shift_stacks
    @stack_oldest.peek
  end

  def dequeue
    shift_stacks
		@stack_oldest.pop
  end
end


# ### Sample Outputs:

que = MyCue.new
que.enqueue(1)
que.enqueue(2)
que.enqueue(3)
que.enqueue(4)
p que.peek
# => 1
p que.dequeue.data
# => 1
p que.dequeue.data
# => 2
p que.dequeue.data
# => 3
p que.dequeue.data
# => 4
