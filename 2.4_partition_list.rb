# ### Problem:
# Write code to partition a linked list around a value x, such that all nodes less than x come before alt nodes greater than or equal to x.

# ### Clarification:
# are we sorting the linked list by the given value? what if none of the nodes holds this value?
# E.g. LinkedList = [ 2,23, 52, 64, 10, 49], x = 50, partitioned_before_x = [ 2, 23, 49 ], partitioned_after_x = [ 52, 64]
# Are we sorting the list on either side around value x?

# ### Assumptions:
# we're assuming that all of the elements/nodes values will be integers
# output linked list isn't sorted
# use linkedlists as datastructure

# ### Solution:
# If this were an array, we would need to be careful about how we shifted elements. Array shifts are very expensive.
# we can actually create two different linked lists: one for elements less than x, and one for elements greater than or equal to x.

require_relative './lib/singly_linked_list'

class SinglyLinkedList

  def partition_list(value)
    before_list = SinglyLinkedList.new
    after_list = SinglyLinkedList.new

    node = self.head

    while node != nil
      if node.data < value
        before_list.add(node.data)
        node = node.next
      else
        after_list.add(node.data) 
        node = node.next
      end
    end

    # ths portion is a bit hacky as there is a @tail in the singlylist data structure implemented. if @tail wasn't there this could be a lot simpler.
    tail_value = before_list.tail.data
    before_list_last = before_list.find(tail_value)
    after_list_head = after_list.head

    # setting the tail node of before_list to head of after_list
    before_list_last.next = after_list_head

    before_list.tail = after_list.tail #this part is a little hacky but will do for now.
    return before_list
  end

end


# ### Sample Output:
linkedlist = SinglyLinkedList.new(10)
linkedlist.add(9)
linkedlist.add(8)
linkedlist.add(1) 
linkedlist.add(11) 
linkedlist.add(7) 
linkedlist.add(3) 
linkedlist
# => #<SinglyLinkedList:0x007fa06481dd08 @head=#<Element:0x007fa06481dce0 @data=10, @next=#<Element:0x007fa06481dcb8 @data=9, @next=#<Element:0x007fa06481dc90 @data=8, @next=#<Element:0x007fa06481dc68 @data=1, @next=#<Element:0x007fa06481dc40 @data=11, @next=#<Element:0x007fa06481dc18 @data=7, @next=#<Element:0x007fa06481dbf0 @data=3, @next=nil>>>>>>>, @tail=#<Element:0x007fa06481dbf0 @data=3, @next=nil>>
p linkedlist.partition_list(5)
# => #<SinglyLinkedList:0x007ff9929bad28 @head=#<Element:0x007ff9929bad00 @data=1, @next=#<Element:0x007ff9929ba828 @data=3, @next=#<Element:0x007ff9929bacb0 @data=10, @next=#<Element:0x007ff9929bab48 @data=9, @next=#<Element:0x007ff9929baa80 @data=8, @next=#<Element:0x007ff9929ba968 @data=11, @next=#<Element:0x007ff9929ba8c8 @data=7, @next=nil>>>>>>>, @tail=#<Element:0x007ff9929ba8c8 @data=7, @next=nil>>
