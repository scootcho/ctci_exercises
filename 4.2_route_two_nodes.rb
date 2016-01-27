# ### Problem:
# Given a directed graph, design an algorithm to find out whether there is a route between two nodes.

# ### Clarification:
# what is a directed graph?  (directed/undirected simply means whether the edges in a graph are bidirectional or not.)
# are we creating a boolean method that checks if two nodes (vertices) are connected?
# will two nodes (verticies) be given as an argument to the algorithm?
# are we looking for if a direct path exist between two nodes that is given? or just that 
# Outdegree - the outdegree of a vertex is the number of edges pointing from it.
# Indegree - of a vertex is the number of edges pointing to it.

# ### Assumptions:
# A directed graph - is graph, i.e., a set of objects (called vertices or nodes) that are connected together, where all the edges are directed from one vertex to another. A directed graph is sometimes called a digraph or a directed network.
# since we are creating a directed graph we know that it can only traverse directions that are given.

# ### Design Algorithm:
# implment a DirectedGraph data structure.
# implment a method to check if weight exists between two vertices

# ### Solution:

require_relative './lib/directed_graph.rb'

class DirectedGraph

  def route_between(s, t)    #s = source, t = terminal
    outdegree = @graph[s]

    if outdegree == nil || false
      false
    else
      outdegree.keys.include?(t)
    end
  end

end


# ### Sample Output:

graph = DirectedGraph.new
graph.add_vertices("a")
graph.add_vertices("b")
graph.add_vertices("c")
graph.add_vertices("d")
graph.add_edge("a", "b", 1)
graph.add_edge("b", "c", 2)
p graph.route_between("a", "b")
# => true
p graph.route_between("d", "c")
# => false


# ### Additional Resources:
# http://algs4.cs.princeton.edu/42digraph/
# http://think-like-a-git.net/sections/graph-theory/directed-versus-undirected-graphs.html
# https://courses.cs.washington.edu/courses/cse326/00wi/handouts/lecture21/sld014.htm
# http://mathworld.wolfram.com/GraphVertex.html
# https://github.com/brianstorti/ruby-graph-algorithms
# http://www.sitepoint.com/graph-algorithms-ruby/
# https://dzone.com/articles/ruby-graph-dijkstra
