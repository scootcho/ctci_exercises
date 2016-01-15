# ### Problem:
# Write code to remove duplicates from an unsorted linked list.
# FOLLOW UP
# How would you solve this problem if a temporary buffer is not allowed?

# ### Clarification:
# Are we creating a method we can use to remove duplicate data from a linked list?
# Are we assuming that each of the element in the linkedlist should be possessing uniq data?

# ### Assumptions:
# I'm assuming that we're not dealing with deallocating memory space messing with Ruby's garbage collector.

# ### Solution:

require_relative './singly_linked_list'

class SinglyLinkedList 

  def remove_duplicates
    uniq = {}
    uniq[@head.data] = 1
    previous = @head
    current = previous.next

    loop do
      while current.next != nil
        if uniq[current.data] == 1
          delete(current.data)
          previous = previous.next  #set previous
          current = previous.next  #move to current node 
        else
          uniq[current.data] = 1
          previous = previous.next
          current = previous.next
        end
      end

      if current.next == nil
        delete(current.data) if uniq[current.data] == 1
        return self
      end
    end
  end

  def remove_duplicates_two_pointers
    #TODO additional implementation: use two pointers without a buffer
  end

end

# ### Sample Output:
linkedlist = SinglyLinkedList.new("first")
linkedlist.add("second")
linkedlist.add("third")
linkedlist.add("fourth")
linkedlist.add("second")
linkedlist.add("third")
# p linkedlist
# => #<SinglyLinkedList:0x007f8d41a9e1f8 @head=#<Element:0x007f8d41a9e1d0 @data="first", @next=#<Element:0x007f8d41a9df28 @data="second", @next=#<Element:0x007f8d41a9ded8 @data="third", @next=#<Element:0x007f8d41a9de88 @data="fourth", @next=#<Element:0x007f8d41a9de38 @data="second", @next=#<Element:0x007f8d41a9dde8 @data="third", @next=nil>>>>>>, @tail=#<Element:0x007f8d41a9dde8 @data="third", @next=nil>>
p linkedlist.remove_duplicates
# => #<SinglyLinkedList:0x007ff924919c48 @head=#<Element:0x007ff924919c20 @data="first", @next=#<Element:0x007ff924919b30 @data="fourth", @next=#<Element:0x007ff924919ae0 @data="second", @next=#<Element:0x007ff924919a90 @data="third", @next=nil>>>>, @tail=#<Element:0x007ff924919a90 @data="third", @next=nil>>


# ### Additional Resources:
# http://www.sitepoint.com/ruby-uses-memory/
# http://collectiveidea.com/blog/archives/2015/02/19/optimizing-rails-for-memory-usage-part-2-tuning-the-gc/
# https://www.airpair.com/ruby-on-rails/performance
# http://samsaffron.com/archive/2014/04/08/ruby-2-1-garbage-collection-ready-for-production
