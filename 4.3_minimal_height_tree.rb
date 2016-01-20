# ### Problem:
# Given a sorted (increasing order) array with unique integer elements, write an algorithm to create a binary search tree with minimal height.

# ### Clarifications:
# Do we want to create a tree with the least amout of nodes extending down the tree?

# ### Assumptions:
# since it's minimal height, we need to spread it to the maximum amounts of nodes on either side, and makes the tree as balance & full as we can.
# To create a tree of minimal height, we need to match the number of nodes in the left subtree to the number of nodes in the right subtree as much as possible.
# This means that we want the root to be the middle of the array, since this would mean that half the elements would be less than the root and half would be greater than it.

# ### Design Algorithm:
# 1. Insert into the tree the middle element of the array.
# 2. Insert (into the left subtree) the left subarray elements.
# 3. Insert (into the right subtree) the right subarray elements.
# 4. Recurse.
# Note: the Tree class has a method that will build a tree from an array. We need to figure out how to properly sort the array to build the tree.

# ### Solution:

require_relative './lib/tree'

class Tree

  def Tree.build_min_tree(array)
    array = array.sort!
    result = []
    completed = []
    tree = Tree.new
    
    # insert root node
    start = 0
    finish = array.length - 1
    mid = start + finish / 2
    tree.insert(array[mid])
    completed << array[mid]
    
    # sort for left subtree
    Tree.sort_for_min(array, start, mid - 1, result)

    p "=== building left subtree ==="
    result.each do |value|
      tree.insert(value)
    end
    completed = completed + result
    result = []

    # sort for right subtree
    Tree.sort_for_min(array, mid + 1, finish, result)
    p "=== building right subtree ==="
    result.each do |value|
      tree.insert(value)
    end
    completed = completed + result
    result = []
   
    remain = array - completed
    if array - completed == []
      p "=== tree completed! ===" 
    else
      remain = array - completed
      p "remaining...."
      p remain
    end
    
    # inserting remaining values
    if remain != []
    p "=== inserting remaining values ==="
      remain.each do |value|
        tree.insert(value)
      end
    end

    return tree
  end

  def Tree.sort_for_min(array, start, finish, result=[])
    if start > finish
      return 0
    end

    mid = (start + finish) / 2
    result << array[mid]

    p "calculating left nodes..."
    p "start: #{start}, mid: #{mid}, finish: #{finish}"
    p result
    sort_for_min(array, start, mid - 1, result)

    p "calculating right nodes..."
    p "start: #{start}, mid: #{mid}, finish: #{finish}"
    p result
    sort_for_min(array, mid + 1, finish, result)

  end

end


# Sample Out:

array = (1..15).to_a
p Tree.build_min_tree(array)
# => #<Tree:0x007fe814896cb0 @root=#<Node:0x007fe814896af8 @value=8, @right=#<Node:0x007fe813831668 @value=12, @right=#<Node:0x007fe81382b998 @value=14, @right=#<Node:0x007fe81382b3f8 @value=15, @right=nil, @left=nil>, @left=#<Node:0x007fe81382b678 @value=13, @right=nil, @left=nil>>, @left=#<Node:0x007fe813832d38 @value=10, @right=#<Node:0x007fe81382bd08 @value=11, @right=nil, @left=nil>, @left=#<Node:0x007fe813833e90 @value=9, @right=nil, @left=nil>>>, @left=#<Node:0x007fe814894118 @value=4, @right=#<Node:0x007fe813842fd0 @value=6, @right=#<Node:0x007fe8138427d8 @value=7, @right=nil, @left=nil>, @left=#<Node:0x007fe813842bc0 @value=5, @right=nil, @left=nil>>, @left=#<Node:0x007fe814894050 @value=2, @right=#<Node:0x007fe8138432a0 @value=3, @right=nil, @left=nil>, @left=#<Node:0x007fe813843b88 @value=1, @right=nil, @left=nil>>>>>
#
# above produces the following tree:
#
#          8
#        /   \
#       4     12
#      /\      /\  
#     2  6   10  14
#    /\  /\  /\   /\
#   1 3 5 7 9 11 13 15


