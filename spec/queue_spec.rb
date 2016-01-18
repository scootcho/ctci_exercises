require 'rspec'
require_relative '../lib/queue'

describe 'Queue' do
  before (:each) do
    @queue = Queue.new("first")
    @queue.enqueue("second")
    @queue.enqueue("third")
  end

  it 'initiates with the first in line' do
    expect(@queue.first.data).to eq("first")
  end

  it 'adds new queue to the last position' do
    @queue.enqueue("fourth")
    expect(@queue.last.data).to eq("fourth")
  end

  it 'dequeques the first in line' do
    @queue.dequeue
    expect(@queue.first.data).to eq("second")
  end

end
