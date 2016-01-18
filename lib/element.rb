# for clarity sake, we will call units stored inside of Linked Lists an element instead of a node. We will use "node" for Trees and Graphs implementations 

class Element
  attr_accessor :data, :next, :prev

  def initialize(data)
    @data = data
    @next = nil
  end
end
