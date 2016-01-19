# ### Problem:
# In the classic problem of the Towers of Hanoi, you have 3 towers and N disks of different sizes which can slide onto any tower. The puzzle starts with disks sorted in ascending order of size from top to bottom (i.e., each disk sits on top of an even larger one). You have the following constraints:
# (1) Only one disk can be moved at a time.
# (2) A disk is slid off the top of one tower onto the next rod.
# (3) A disk can only be placed on top of a larger disk.
# Write a program to move the disks from the first tower to the last using Stacks.

# ### Clarification:
# Is there a difference between Tower2 or Tower3? Or can we move the disks to either one as long as it's completed?
# Can we use Tower1 (the starting tower as buffer?

# ### Assumption:
# No difference between Tower2(T2) & Tower3(T3) as destination tower as long as disks are moved and stacked in ascending order.
# Use Tower1 as buffer

# ### Design Algorithm:
# This problem sounds like a good candidate for the Base Case and Build approach.
# Start with the smallest example and build on top of the previous.
# one of the towers acts as a buffer, as long as tower is completed on T2 or T3 is the same.
# Case n = 1; move D1 from T1 to T3. (D1 on T3)
# Case n = 2; continue form n = 1, move D2 from T1 to T2, D1 from T3 to T2. (D1,D2 on T2) 
# Case n = 3; continue from n = 2; move D3 from T1 to T3, D1 from T2 to T1, D2 from T2 to T3, D1 from T2 to T3. (D1,D2,D3 on T3) 
# Case n = 4; continue from n = 3; move D4 from T1 to T2, D1 from T3 to T2, D2 from T3 to T1, D1 from T2 to T1, D3 from T3 to T2, D1 from T1 to T3, D2 from T1 to T2, D1 from T3 to T2. (D1,D2,D3,D4 on T2)
# Once we start to see a pattern emerge we can work on the solution.
# In order to stack size n to destination, we have to stack n - 1 completely in the buffer. E.g., In order to move tower of 4 disks, we must first stack 1,2,3 in buffer first and move disk 4 to destination.

# ### Solution:

require_relative './lib/stack'

class Tower
  attr_accessor :origin, :destination, :buffer

  def initialize(num_disks)
    raise ArgumentError, "Please supply a number greater than 1 for the disks in Tower" unless num_disks.is_a?(Fixnum)
    @num_disks = num_disks
    @origin = Stack.new()
    @buffer = Stack.new()
    @destination = Stack.new()
    disks = (1..num_disks).to_a.reverse
    disks.each { |disk| @origin.push(disk) }
    p "Initialized Tower with #{@num_disks} disks"
    @origin 
  end

  def add(destination, disk)
		if !destination.is_empty? && destination.peek <= disk
      puts "Error placing disk #{disk}"
		else
			destination.push(disk)
    end
  end

  # move top from origin to destination
  def move_top(origin, destination)
		disk = origin.pop.data
		add(destination, disk)
  end

  def move_disks(num_disks, origin, destination, buffer)
    raise ArgumentError, "sorry you cannot move more disks than you have in the towers" if num_disks > @num_disks
    if num_disks == 1
      puts "Move Disc from orgin to destination!"
      move_top(origin, destination)
    else
      move_disks(num_disks - 1, origin, buffer, destination) # move top n - 1 disks from origin to buffer, using destination * as a buffer.
      move_disks(1, origin, destination, buffer)
      move_disks(num_disks - 1, buffer, destination, origin) # move top n - 1 disks from buffer to destination, using * origin as a buffer. 
    end
  end

end


# ### Sample Output:
towers = Tower.new(5)
towers.move_disks(5, towers.origin, towers.destination, towers.buffer)
p towers
# => #<Tower:0x007fc0b29ba508 @num_disks=5, @origin=#<Stack:0x007fc0b29ba4e0 @top=#<Element:0x007fc0b29ba4b8 @data=nil, @next=nil>, @bottom=#<Element:0x007fc0b29ba4b8 @data=nil, @next=nil>>, @buffer=#<Stack:0x007fc0b29ba490 @top=#<Element:0x007fc0b29ba468 @data=nil, @next=nil>, @bottom=#<Element:0x007fc0b29ba468 @data=nil, @next=nil>>, @destination=#<Stack:0x007fc0b29ba440 @top=#<Element:0x007fc0b29b97e8 @data=1, @next=#<Element:0x007fc0b29b9860 @data=2, @next=#<Element:0x007fc0b29b9900 @data=3, @next=#<Element:0x007fc0b29b9a40 @data=4, @next=#<Element:0x007fc0b29ba418 @data=5, @next=nil>>>>>, @bottom=#<Element:0x007fc0b29ba418 @data=5, @next=nil>>>


# ### Additional Resources:
# http://codereview.stackexchange.com/questions/73400/towers-of-hanoi?newreg=c261754c1ce34906a9d351922a9623b8
# http://www.skorks.com/2010/03/solving-the-towers-of-hanoi-mathematically-and-programmatically-the-value-of-recursion/
# http://www.thelearningpoint.net/computer-science/introduction-to-ruby---towers-of-hanoi-an-example-of-recursion
# http://www.math.harvard.edu/computing/ruby/hanoi.rb
