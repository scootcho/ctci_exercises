require 'active_support/core_ext/kernel/reporting'
require_relative '../../lib/directed_graph'

describe 'DirectedGraph' do
  before (:each) do
    @graph = DirectedGraph.new
  end

  it 'initializes with empty array to store nodes' do
    expect(@graph.nodes).to eq([]) 
  end

  it 'add_edge uses hashes to store source, destination and weight of vertex' do
    @graph.add_edge("a","b",5)
    expect(@graph.graph["a"]).to eq({"b"=>5}) 
  end

  it 'add_edge addes vertices to nodes if it was nonexistent' do
    @graph.add_edge("b","c",3)
    @graph.add_edge("c","d",1)
    expect(@graph.nodes).to eq(["b","c","d"]) 
  end

  it 'builds a graph given initialization arguments' do
    pending
  end

  it 'traverse graph and peform breadth_first_search' do
    pending
  end 

  it 'traverse graph and peform depth_first_search' do
    pending
  end

end
