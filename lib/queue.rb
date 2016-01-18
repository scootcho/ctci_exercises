require_relative './element'

class Queue
  attr_accessor :first, :last

  def initialize(data=nil)
    @first = Element.new(data)
    @first.next = nil
    @last = @first 
  end

  def enqueue(data)
    if @first.data == nil
      @first.data = data
    else
      new = Element.new(data)
      @last.next = new
      @last = @last.next
    end
  end

  def dequeue
    raise OperationError.new("The queue is empty!") if @first == nil
    @first = @first.next
  end

end

class OperationError < StandardError; end
