require_relative './element.rb'

class Stack
  attr_accessor :top, :bottom, :data

  def initialize(data=nil)
    @top = Element.new(data)
    @top.next = nil
    @bottom = @top
  end

  def push(data)
    if @top.data == nil
      @top.data = data
    else
      new = Element.new(data)
      new.next = @top
      @top = new
    end
  end

  def pop
    raise OperationError.new("The stack is empty or nil!") if @top.data == nil
    if @top.next == nil
      value = @top
      @top.data = nil
      @bottom = @top
      p value
    else
      @top = @top.next
    end
  end

  def peek
    raise OperationError.new("The stack is empty or nil!") if @top.data == nil
    p @top.data
  end

end

class OperationError < StandardError; end
