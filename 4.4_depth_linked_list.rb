# ### Problem:
# Given a binary tree, design an algorithm which creates a linked list of all the nodes at each depth (e.g., if you have a tree with depth D, you'll have D linked lists).

# ### Clarifications:
# are we creating a methods that will generate number of link lists that contain all nodes on each depth?
# do the order in linked list matters on each depth? 

# ### Assumptions:
# order matters on each depth. Example:
#
#         6
#        / \
#       3   7
#      /\    \
#     2  5    8
#    /  /      \
#   1  4        9
#
# above should produce 4 lists
# 6
# 3->7
# 2->5->8
# 1->4->9

# ### Design Algorithm:
# depth first search traversal
# implement a simple modification of the pre-order traversal algorithm, where we pass in level + 1 to the next recursive call
# this solution run in O(N) time

# ### Solution:

require_relative './lib/tree'
require_relative './lib/singly_linked_list'

class Tree

  # #Pre-Order Traversal (self, left subtree, right subtree)
  # def pre_order_traversal(node= @root)
  #   return if (node == nil)
  #   puts node.value.to_s
  #   pre_order_traversal(node.left)
  #   pre_order_traversal(node.right)
  # end

  def create_level_linked_list(node, lists, level)
    return if (node == nil) #base case
    if lists.size == level
      p "creating new list for level"
      p "node: #{node.value}"
      list = SinglyLinkedList.new
      # Levels are always traversed in order. So, if this is the first time we've visited level i,
      # we must have seen levels 0 through i - 1. We can therefore safely add the level at the end.
      lists << list
    else
      p "adding to level linked list"
      p "node: #{node.value}"
      list = lists[level]
    end
    list.add(node.value)
    create_level_linked_list(node.left, lists, level + 1)
    create_level_linked_list(node.right, lists, level + 1)
    return lists
  end

  # TODO additional implementation - breadth first search
end

# ### Sample Output:
tree = Tree.build_tree([6,3,7,2,5,8,1,4,9])
tree.pre_order_traversal
lists = tree.create_level_linked_list(tree.root, lists=[], 0)
p lists
p lists[0]
# => #<SinglyLinkedList:0x007fa2ab9aba28 @head=#<Element:0x007fa2ab9aba00 @data=6, @next=nil>, @tail=#<Element:0x007fa2ab9aba00 @data=6, @next=nil>>
p lists[1]
# => #<SinglyLinkedList:0x007fa2ab9ab870 @head=#<Element:0x007fa2ab9ab848 @data=3, @next=#<Element:0x007fa2ab9aafb0 @data=7, @next=nil>>, @tail=#<Element:0x007fa2ab9aafb0 @data=7, @next=nil>>
p lists[2]
# => #<SinglyLinkedList:0x007fa2ab9ab6b8 @head=#<Element:0x007fa2ab9ab690 @data=2, @next=#<Element:0x007fa2ab9ab348 @data=5, @next=#<Element:0x007fa2ab9aad30 @data=8, @next=nil>>>, @tail=#<Element:0x007fa2ab9aad30 @data=8, @next=nil>>
p lists[3]
# => #<SinglyLinkedList:0x007fa2ab9ab500 @head=#<Element:0x007fa2ab9ab4d8 @data=1, @next=#<Element:0x007fa2ab9ab190 @data=4, @next=#<Element:0x007fa2ab9aaba0 @data=9, @next=nil>>>, @tail=#<Element:0x007fa2ab9aaba0 @data=9, @next=nil>>



