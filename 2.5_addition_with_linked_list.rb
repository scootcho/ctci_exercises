# ### Problem:
# You have two numbers represented by a linked list, where each node contains a single digit. The digits are stored in reverse order, such that the 1's digit is at the head of the list. Write a function that adds the two numbers and returns the sum as a linked list.
# FOLLOW UP
# Suppose the digits are stored in forward order. Repeat the above problem.

# ### Clarification:
# What is an example of the list?
# For the number 432, the linkedlist will have 3 nodes, each containing a single digit. Head->2,3,4 since the number is stored in reversed order.
# linkedlist1(624): head->4,2,6 + linkedlist2(476): Head->6,7,4 => result_linked_list(1000): Head->1,0,0,0
# if input lists are in reversed order, should the output list also in reversed order?

# ### Assumption:
# if inputs are reversed order, outputs should be reversed ordered as well.

# ### Solution:

require_relative './lib/singly_linked_list'

class SinglyLinkedList

  # when lists are stored in reverse order. We don't have to consider the lenghts of lists
  def self.reverse_add_lists(list1, list2)
    node1  = list1.head
    node2 = list2.head
    sum_list = SinglyLinkedList.new

    carry = 0  
    until node1 == nil && node2 == nil
      p "node1: #{node1.data}, node2: #{node2.data}, carry: #{carry}"
      if node1 == nil && node2 != nil
        value = node2.data
      elsif node1 != nil && node2 == nil 
        value = node1.data
     else
        value = node1.data + node2.data
      end
      value = value + carry
      carry = 0
      if value >= 10
        value = value % 10    
        carry = 1
      end
      sum_list.add(value)
      node1 = node1.next
      node2 = node2.next
    end 
    sum_list.add(carry) if carry != 0

    p sum_list
  end
end
#TODO implement solution for follow up question


# ### Sample Output:

#number 624
list1 = SinglyLinkedList.new(4)
list1.add(2)
list1.add(6)

#number 376
list2 = SinglyLinkedList.new(6)
list2.add(7)
list2.add(3)

SinglyLinkedList.reverse_add_lists(list1, list2)
# => #<SinglyLinkedList:0x007ff682a9c678 @head=#<Element:0x007ff682a9c650 @data=0, @next=#<Element:0x007ff682a9c3f8 @data=0, @next=#<Element:0x007ff682a9c2b8 @data=0, @next=#<Element:0x007ff682a9c290 @data=1, @next=nil>>>>, @tail=#<Element:0x007ff682a9c290 @data=1, @next=nil>>
