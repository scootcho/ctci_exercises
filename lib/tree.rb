require_relative './node'
# credit http://www.thelearningpoint.net/computer-science/basic-data-structures-in-ruby---binary-search-tre

# Node = Struct.new(:value, :left, :right) #we can also use Struct

class Tree
  attr_accessor :root

  def initialize(value = nil)
    value == nil ? (puts "initailizing with empty root") : ("initializing with #{value.to_s}")
    @root = Node.new(value)
  end

  def Tree.build_tree(array)
    tree = Tree.new
    array.each do |value|
      tree.insert(value)
    end
    return tree
  end
 
  # Binary Search Tree Insert
  def insert(value)
    puts "inserting: " + value.to_s
    @root.value = value if @root.value == nil

    current_node = @root
    while current_node != nil
      if (value < current_node.value) && (current_node.left == nil)
        current_node.left = Node.new(value)
      elsif (value > current_node.value) && (current_node.right == nil)
        current_node.right = Node.new(value)
      elsif (value < current_node.value)
        current_node = current_node.left
      elsif (value > current_node.value)
        current_node = current_node.right
      else
        return
      end
    end
  end 

  # Binary Tree Insert 
  def insert_bt(value)
    puts "inserting: " + value.to_s
    current_node = @root
    if @root.value == nil
      @root.value = value
    elsif (current_node.left == nil)
      current_node.left = Node.new(value)
    elsif (current_node.right == nil)
      current_node.right = Node.new(value)
    elsif  current_node.left.value == nil
      current_node.left = value
    elsif  current_node.right.value == nil
      current_node.rigth = value
    else
      return
    end
  end 
 
  # Pre-Order Traversal (self, left subtree, right subtree)
  def pre_order_traversal(node= @root)
    return if (node == nil)
    puts node.value.to_s
    pre_order_traversal(node.left)
    pre_order_traversal(node.right)
  end

  # In-Order Traversal : (left subtree, self, right subtree)
  # Display smaller children first (by going left)
  # Then display the value in the current node 
  # Then display the larger children on the right
  def in_order_traversal(node = @root)
    return if (node == nil)
    in_order_traversal(node.left)
    puts node.value.to_s
    in_order_traversal(node.right)
  end

  # Post-Order Traversal (left subtree, right subtree, self)
  def post_order_traversal(node = @root)
    return if (node == nil)
    post_order_traversal(node.left)
    post_order_traversal(node.right)
    puts node.value.to_s
  end

end

p tree = Tree.build_tree([3,2,1,5,4])
p tree.pre_order_traversal

# Resources:
# http://www.thelearningpoint.net/computer-science/basic-data-structures-in-ruby---binary-search-tre
# http://www.mikeperham.com/2014/11/26/building-a-binary-tree-with-enumerable/
# https://github.com/evolve75/RubyTree
