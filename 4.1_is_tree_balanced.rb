
# Implement a function to check if a binary tree is balanced. For the purposes of this question, a balanced tree is defined to be a tree such that the heights of the two subtrees of any node never differ by more than one.

# ### Clarification:
# Is the tree a binary search tree?
# we want to make sure a given tree, the height of the right and left subtrees will not differ by more than one level?

# ### Assumptions:
# the tree is only balanced if:
# 1) The left and right subtrees' heights differ by at most one, AND
# 2) The left subtree is balanced, AND
# 3) The right subtree is balanced
# we're creating a method/function that checks the height of the right and left subtrees

# ### Design Algorithm:
# since we care about the height, we want to traverse depth first, hence a DFS
# traverse the tree's depth on either side of the binary tree and count how many levels there are

# ### Solution:

require_relative './lib/tree'

class Tree

#  def Tree.get_height(root)
#    return 0 if root == nil
#    [ get_height(root.left), get_height(root.right) ].max + 1
#  end
#
#  def Tree.is_balanced?(root)
#    return true if root == nil
#   
#   height_diff = get_height(root.left) - get_height(root.right) 
#
#    if height_diff > 1
#      return false
#   else
#     return is_balanced?(root.left) && is_balanced?(root.right)
#   end 
#  end
#  This works but not very efficient. On each node, we recurse through its entire subtree. This means that get_height is called repeatedly on the same nodes. The algorithm is therefore O(N^2).

  def Tree.check_height(root)
    if root == nil
      return 0
    end
    p "node: #{root}, node value: #{root.value}"

    p "traversing left...."
    left_height = check_height(root.left)

    p "left_height: #{left_height}"
    p "eval left...."
    if left_height == -1 
      return -1
    end
    
    p "traversing right...."
    right_height = check_height(root.right)

    p "right_height: #{right_height}"
    p "eval right...."
    if right_height == -1 
      return -1
    end 
    
    p "left_height: #{left_height}, right_height: #{right_height}"
    height_diff = left_height - right_height

    if height_diff.abs > 1
      p "===== subtree difference > 1 ======"
      return -1
    else 
      p "===== evaluating ======"
      p [left_height, right_height].max + 1
      return 1 + [left_height, right_height].max
    end
  end
  
  def Tree.is_balanced?(root)
    if check_height(root) == -1
      return false
    else
      return true
    end
  end
  
end


# ### Sample Output:
tree = Tree.build_tree([6,3,2,1,7,9,8])
# above produces the following tree:
#
#         6
#        / \
#       3   7
#      /     \
#     2       9
#    /       /  
#   1       8    
#
p Tree.is_balanced?(tree.root)
# => false
#
tree = Tree.build_tree([6,3,2,1,5,4,7,8,9])
# above produces the following tree:
#
#         6
#        / \
#       3   7
#      /\    \
#     2  5    8
#    /  /      \
#   1  4        9
#
# p Tree.is_balanced?(tree.root)
#
# => false
# the tree isn't balanced because starting node 7 the subtree is different in height more than 1
#
tree = Tree.build_tree([6,3,2,1,5,4,8,7,9])
p Tree.is_balanced?(tree.root)
# above produces the following tree:
#
#         6
#        / \
#       3   8
#      /\   /\
#     2  5 7  9
#    /  /      
#   1  4        
#
# p Tree.is_balanced?(tree.root)
# => true


# ### Additional Resources:
# http://algorithms.tutorialhorizon.com/find-whether-if-a-given-binary-tree-is-balanced/
# http://stackoverflow.com/questions/8015630/definition-of-a-balanced-tree
