require 'active_support/core_ext/kernel/reporting' #use ruby 2.2.2 or above
require_relative '../../lib/directed_graph'

describe 'DirectedGraph' do
  before (:each) do
    @graph = DirectedGraph.new
  end

  it 'initializes with empty array to store.vertices' do
    expect(@graph.vertices).to eq([]) 
  end

  it 'add_edge uses hashes to store source, destination and weight of vertex' do
    @graph.add_edge("a","b",5)
    expect(@graph.graph["a"]).to eq({"b"=>5}) 
  end

  it 'add_edge addes vertices to.vertices if it was nonexistent' do
    @graph.add_edge("b","c",3)
    @graph.add_edge("c","d",1)
    expect(@graph.vertices).to eq(["b","c","d"]) 
  end

  it 'puts message if vertex already exist' do
    @graph.add_vertices("a","c","d")
    output = capture(:stdout) do
      @graph.add_edge("a","b",1)
    end
    expect(output).to match(/vertex already exist!/)
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
