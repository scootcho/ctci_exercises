require_relative './element'

class SinglyLinkedList
  attr_accessor :head, :tail

  def initialize(data=nil)
    @head = Element.new(data)
    @head.next = nil
    @tail = @head
  end

  def add(data)
    if @head.data == nil
      @head.data = data
    else
      @tail.next = Element.new(data)
      @tail = @tail.next
      @tail.next = nil
    end
  end

  def delete(data) #need to specify the data of the node to be deleted
    if @head.data == data
      @head = @head.next
    else
      previous = @head
      current = @head.next
      unless current.next == nil
        if current.data == data
          previous.next = current.next
        else
          previous = current
        end
      end
    end
  end

  def find(data) #how should we find the node? by data it's holding? This requires each node to have unique data
    current_node = @head
    while current_node != nil
      if current_node.data == data  
        return current_node
      else
        current_node = current_node.next
      end
    end
  end

  def return_list
    # start with @head
    list = []
    current_node = @head
    
    while current_node != nil
      node = current_node
      case node
      when @head
        node = ["HEAD - data: #{current_node.data}, next: #{current_node.next}"]
      when @tail
        node = ["TAIL - data: #{current_node.data}, next: #{current_node.next}"] 
      else 
        node = ["NODE - data: #{current_node.data}, next: #{current_node.next}"]
      end
      list << node 
      current_node = current_node.next
    end

    puts "Linked Lists:"
    return list
  end
end

