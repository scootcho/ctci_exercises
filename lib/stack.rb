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
      element = @top.dup
      @top.data = nil #manually setting data to nil to prevent @top = nil
      @bottom = @top
      element
    else
      element = @top
      @top = @top.next
      element
    end
  end

  def peek
    raise OperationError.new("The stack is empty or nil!") if @top.data == nil
    @top.data
  end

  def is_empty?
    @top.data == nil ? true : false
  end

end

class OperationError < StandardError; end
