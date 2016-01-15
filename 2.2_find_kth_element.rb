# ### Problem:
# Implement an algorithm to find the kth to last element of a singly linked list.

# ### Clarification:
# Are we creating an algorithm to find the kth to the last element in a singly linked list? This means we can only traverse in one direction only?
# Is the last element the tail node? If so then, 2 to last is the 2nd element counting from last element in the list?
# is the length of the linked list known? if it is, we can do (length - k) element and located the position and value of the node. 

# ### Assumptions:
# it's a singly linked list
# how are we defining the last node of the list? is it k = 1 or k = 0

# ### Solution:
# implementing p1, p2, with k length method:

# Solution #1: If linked list size is known
# If the size of the linked list isknown, then the kth to last element isthe (length - k) th element. We can just iterate through the linked list to find this element. Because this solution is so trivial, we can almost be sure that this is not what the interviewer intended

# Solution #2: Recursive
# This algorithm recurses through the linked list. When it hits the end, the method passes back a counter set to 0. Each parent call adds 1 to this counter. When the counter equals k, we know we have reached the kth to last element of the linked list.

# Solution #3: Iterative
# explained
# place p1 & p2 by k nodes apart. E.g., k = 3, p1 = 0, p2 = 3, when p2 hits last node, p1 is at the location of Length - k

require_relative './singly_linked_list.rb'

class SinglyLinkedList

  def kth_to_last(k)
    pointer_1 = @head 
    pointer_2 = @head 

    for i in 0...k - 1
      puts "ERROR" if pointer_2 == nil
      pointer_2 = pointer_2.next  #this traverse pointer_2 for k number of nodes    
      i += 1
    end

    while pointer_2.next != nil
      pointer_1 = pointer_1.next  #now pointer_1 and pointer_2 will traverse at the same pace since pointer_2 has traversed kth nodes
      pointer_2 = pointer_2.next  
    end
    
    return pointer_1 #when pointer_2 hits the last node (node.next = nil) pointer_1 will be at the kth to last node.
  end

end


# ### Sample Output:
linkedlist = SinglyLinkedList.new("first")
linkedlist.add("second")
linkedlist.add("third")
linkedlist.add("fourth")
p linkedlist.kth_to_last(1) 
# => #<Element:0x007ff7041bb4a0 @data="fourth", @next=nil>


# ### Additional Resources:
# http://carlosplusplus.github.io/blog/2013/08/08/linked-lists-and-ruby/
# http://matt.weppler.me/2013/08/14/implementing-a-linked-list-in-ruby.html
