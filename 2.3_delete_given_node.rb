# ### Problem:
# Implement an algorithm to delete a node in the middle of a singly linked list, given only access to that node.

# ### Clarification:
# the given node will be in the middle of a signly linked list. Meaning it won't be either the first or last node in the list?

# ### Solution:
# The solution is simply to copy the data from the next node over to the current node, and then to delete the next node.
# if the node to be deleted is the last node in the linked list. That's ok—your interviewer wants you to point that out, and to discuss how to handle this case
# because it's a singly linkedlist we only have the pointer address to the next node and not the previous one. Hence if the given node is the last, the solution won't work as we can replace the previous node as the last node in the linked list

# ### Solution:

require './lib/singly_linked_list'

class SinglyLinkedList

  def delete_given_node(node) #what will be the input here? Will it be the actul node? If that's the case we'll need detailed node information - node object id, etc
    raise NodeError.new("Argument cannot be the last node or an empty node!") if (node.next == nil || node == nil)

    node.data = node.next.data
    node.next = node.next.next
  end

end

class NodeError < StandardError; end

# ### Sample Output:
linkedlist = SinglyLinkedList.new("first")
linkedlist.add("second")
linkedlist.add("third")
linkedlist.add("fourth") 
node = linkedlist.find("second")
linkedlist.delete_given_node(node)
p linkedlist
# => #<SinglyLinkedList:0x007fb389013b98 @head=#<Element:0x007fb389013b70 @data="first", @next=#<Element:0x007fb389013af8 @data="third", @next=#<Element:0x007fb389013a58 @data="fourth", @next=nil>>>, @tail=#<Element:0x007fb389013a58 @data="fourth", @next=nil>>
