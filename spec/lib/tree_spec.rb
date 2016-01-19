require 'active_support/core_ext/kernel/reporting'
require_relative '../../lib/tree'

describe 'Tree' do
  before (:each) do
    @tree = Tree.new()
  end

  it 'initializes with nil root value when initial argument is empty' do
    expect(@tree.root.value).to eq(nil) 
  end

  it 'initializes with root value when initialized' do
    @tree.insert(1)
    expect(@tree.root.value).to eq(1) 
  end

  it 'inserts into left when value is greater than node' do
    @tree.insert(1)
    @tree.insert(2)
    expect(@tree.root.right.value).to eq(2)
  end

  it 'inserts into right when value is greater than node' do
    @tree.insert(3)
    @tree.insert(2)
    expect(@tree.root.left.value).to eq(2)
  end

  it 'insert values to tree, value less than node is inserted recursively to left' do
    @tree.insert(3)
    @tree.insert(2)
    @tree.insert(1)
    expect(@tree.root.left.left.value).to eq(1) 
  end

  it 'insert values to tree, value less than node is inserted recursively to right' do
    @tree.insert(3)
    @tree.insert(4)
    @tree.insert(5)
    expect(@tree.root.right.right.value).to eq(5) 
  end

  it 'insert values to tree, value is inserted after traverse to appropriate position' do
    @tree.insert(3)
    @tree.insert(2)
    @tree.insert(1)
    @tree.insert(5)
    @tree.insert(4)
    expect(@tree.root.right.left.value).to eq(4) 
  end

  it 'builds a tree given an array' do
    @tree = Tree.build_tree([3,2,1,5,4])
    expect(@tree.root.right.left.value).to eq(4) 
  end

  it 'traverse tree in pre-order fashion' do
    @tree = Tree.build_tree([3,2,1,5,4])
    output = capture(:stdout) do
      @tree.pre_order_traversal
    end
    expect(output).to eq("1\n2\n4\n5\n3\n")
  end

  it 'traverse a tree in in-order fashion' do
    @tree = Tree.build_tree([3,2,1,5,4])
    output = capture(:stdout) do
      @tree.in_order_traversal
    end
    expect(output).to eq("1\n2\n3\n4\n5\n")
  end

  it 'traverse tree in pre-order fashion' do
    @tree = Tree.build_tree([3,2,1,5,4])
    output = capture(:stdout) do
      @tree.post_order_traversal
    end
    expect(output).to eq("3\n2\n1\n5\n4\n")
  end

end
