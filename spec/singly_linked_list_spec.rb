require 'rspec'
require_relative '../lib/singly_linked_list'

describe 'Singlely Linked List' do

  context 'the first element Element' do
    before (:each) { @linkedlist = SinglyLinkedList.new("first") }

    it 'is inserted as the head' do
      expect(@linkedlist.head.data).to eq("first")
    end

    it 'is both the head and the tail' do
      expect(@linkedlist.head).to eq(@linkedlist.tail)
    end
  end

  context 'elements in linkedlist' do
    before (:each) do
      @linkedlist = SinglyLinkedList.new("first")
      @linkedlist.add("second")
      @linkedlist.add("third")
      @linkedlist.add("fourth")
    end

    it 'is added at the tail of the list' do
      @linkedlist.add("fifth")
      expect(@linkedlist.tail.data).to eq("fifth")
    end 

    it 'retains the first element as head' do
      expect(@linkedlist.head.data).to eq("first")
    end

    it 'does not have a next pointer as tail' do
      @linkedlist.add("fifth")
      expect(@linkedlist.tail.next).to eq(nil)
    end

    it 'deletes elements data' do
      @linkedlist.delete("second")
      expect(@linkedlist.head.next.data).to eq("third")
    end

    it 'replaces head when removed' do
      @linkedlist.delete("first")
      expect(@linkedlist.head.data).to eq("second")
    end

    it 'returns a list of elements in the linkedlist' do
      list = @linkedlist.return_list
      expect(list.length).to eq(4)
    end
  end
end

