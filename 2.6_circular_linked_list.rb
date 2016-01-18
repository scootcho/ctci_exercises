# ### Problem:
# Given a circular linked list, implement an algorithm which returns the node at the beginning of the loop.

# ### Clarification:
# we're given a circular linked list. our objective is to find the beginning of the loop.
# does this linked list have links that are not part of the loop?

# ### Assumption:
# There is a loop somewhere in the linked list

# ### Develop Algorithm:
# Step 1: Detect If Linked List Has A Loop 
# An easy way to detect if a linked list has a loop is through the FastRunner / SlowRunner approach. FastRunner moves two steps at a time, while SlowRunner moves one step, eventually FastRunner will lap SlowRunner. Even if FastRunner "hop over" the SlowRunner, they will collide as SlowRunner moves one step at a time and will collide right as FastRunner hopped over at that iteration.

# Step 2: When Do They Collide?
# Let's assume that the linked list has a "non-looped" part of size k.
# when SlowRunner enters the looped portion after k steps, FastRunner has taken 2k steps total and must be 2k - k steps, or k steps, into the looped portion
# let L = loopsize
# let StartOfLoop = node at the beginning of loop
# Since k might be much larger than the loop length, we should actually write this as Modular or (k MOD L ) or k % L steps, where L is the denominator/total steps in the loop.
# * SlowRunner is 0 steps into L
# * FastRunner is at (k % L) steps
# * Both Runners are (k % L) steps apart
# * FastRunner catches up 1 step / unit of time
# * FastRunner is L - (k % L) steps behind SlowRunner (this is the remaining steps for FastRunner to catch up to SlowRunner since the distance will be reduced 1 step / unit of time)
# * once SlowRunner steps into the loop, the collision will happen exactly k steps before the SlowRunner reaching the Start of the Loop. Remember that k is also number of steps it takes to get to the loop
# * Hence CollisionSpot = StartOfLoop - (k % L)

# Step 3: How Do You Find The Start of the Loop?
# * once CollisionSpot is found, node at the StartOfLoop is simple. (note that we still don't exactly know what k is)
# * We need two pointers. One at the collission spot, another one at the very beginning of the linkedlist, before the loop.
# * we start the two pointers at the same speed. When the two pointers collide, that node will be the beginning of loop. (also what k is)

# ### Solution:
# This is a modification of a classic interview problem: detect if a linked list has a loop. Let's apply the Pattern Matching approach.
# Tips:
# 1. Createtwo pointers, FastPointer and SlowPointer.
# 2. Move FastPointer at a rate of 2 steps and SlowPointer at a rate of 1 step.
# 3. When they collide, move SlowPointer to LinkedListHead. Keep FastPointer where it is.
# 4. Move SlowPointer and FastPointer at a rate of one step. Return the new collision point.

require_relative './lib/singly_linked_list'

class SinglyLinkedList

  def self.find_loop_start(list)
    slow = list.head
    fast = list.head

		# Find meeting point
		while fast != nil && fast.next != nil do
			slow = slow.next
			fast = fast.next.next
			if slow == fast
        p "loop found! starting at node #{slow}"
				break
      end
    end
  end

end


# ### Sample Output:
list = SinglyLinkedList.new(1)
list.add(2)
list.add(3)
list.add(4)
list.add(5)
list.add(6)
list.add(7)
node = list.find(4)
# creating a circular list
list.head.next.next.next.next.next.next.next = node
node = list.head
node.next.next.next.next.next.next.next.next.next.next.next.next.next.next.next.next.next.next.next.next.next.next.next.next.next.next.next.next.next.next
# => #<Element:0x007f970a829760 @data=7, @next=#<Element:0x007f970a89b900 @data=4, @next=#<Element:0x007f970a870548 @data=5, @next=#<Element:0x007f970a859050 @data=6, @next=#<Element:0x007f970a829760 ...>
SinglyLinkedList.find_loop_start(list)
# => "loop found! starting at node #<Element:0x007f908c07a7c8>"


# Aditional Resources
# htps://www.khanacademy.org/computing/computer-science/cryptography/modarithmetic/a/what-is-modular-arithmetic
# http://www.keblog.me/2014/12/cracking-coding-interview-q26-circular-linked-list/
