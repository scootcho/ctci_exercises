# Undirected graph - a graph in which the connecting lines don't have arrows; two nodes are either connected or they are not.
# Digraph - a graph that have "one-way streets;" just because node x is connected to node y doesn't mean that the reverse is true.
# A self-loop - is an edge that connects a vertex to itself.
# Outdegree - the outdegree of a vertex is the number of edges pointing from it.
# Indegree - of a vertex is the number of edges pointing to it.
# A node - is also commonly called a vertex.
# Weight - a weighted graph has connections (or edges) that have weights associated with them; these weights may express, for instance, the "distance" between two nodes.


class DirectedGraph
  attr_reader :graph, :nodes

  def initialize
    @graph = {}  # the graph // {node => { edge1 => weight, edge2 => weight}, node2 => ...
    @nodes = Array.new     
  end

  def add_node(s)
    if @nodes.include?(s)
      puts "the node already exists!"
    else
      @nodes << s
    end
  end
    
  def add_edge(s,t,w)     # s= source, t= target, w= weight
    if @graph.has_key?(s)
      @graph[s][t] = w         
    else
      @graph[s] = {t=>w}     
    end
    
    # Begin code for non directed graph (inserts the other edge too)
    # if (not @graph.has_key?(t))
    #   @graph[t] = {s=>w}
    # else
    #   @graph[t][s] = w
    # end
    # End code for non directed graph (ie. deleteme if you want it directed)

    # add source or target nodes if nonexistent
    if !@nodes.include?(s)
      @nodes << s
    end
    if !@nodes.include?(t)
      @nodes << t
    end 
  end
  
end


# Additional Resources:
# http://www.informit.com/articles/article.aspx?p=26943&seqNum=6
# https://dzone.com/articles/ruby-graph-dijkstra
# http://www.sitepoint.com/graph-algorithms-ruby/
