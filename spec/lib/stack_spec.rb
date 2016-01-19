require 'rspec'
require_relative '../../lib/stack'

describe 'Stack' do
  before (:each) do
    @stack = Stack.new("bottom")
    @stack.push("middle")
    @stack.push("top")
  end

  it 'initiates with the first in bottom' do
    expect(@stack.bottom.data).to eq("bottom")
  end

  it 'retains the last stacked item at top' do
    expect(@stack.top.data).to eq("top")
  end

  it 'can only peek the top of the stack' do
    expect(@stack.peek).to eq("top")
  end

  it 'pops stacks off from the top' do
    @stack.pop
    expect(@stack.peek).to eq("middle")
  end

  it 'push new item to top' do
    @stack.push("new")
    expect(@stack.top.data).to eq("new")
  end

  it 'display false when stack is empty' do
    @stack.pop
    @stack.pop
    @stack.pop
    expect(@stack.is_empty?).to eq(true)
  end

end
