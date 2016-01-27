# Undirected graph - a graph in which the connecting lines don't have arrows; two nodes are either connected or they are not.
# Digraph - a graph that have "one-way streets;" just because node x is connected to node y doesn't mean that the reverse is true.
# A self-loop - is an edge that connects a vertex to itself.
# Outdegree - the outdegree of a vertex is the number of edges pointing from it.
# Indegree - of a vertex is the number of edges pointing to it.
# A node - is also commonly called a vertex.
# Weight - a weighted graph has connections (or edges) that have weights associated with them; these weights may express, for instance, the "distance" between two nodes.


class DirectedGraph
  attr_reader :graph,  :vertices, :adjacency_matrix

  def initialize(*vertices)
    @graph = {}       # the graph // {node => { edge1 => weight, edge2 => weight}, node2 => ...
    @vertices = []
    vertices.each { |vertex| @vertices << vertex }
  end

  def add_vertices(*vertices)
    vertices.each do |vertex|
      if !@vertices.include?(vertex) 
        @vertices << vertex
      else
        puts "#{vertex} vertex already exist!"
      end
    end
  end
    
  def add_edge(s, t, w)     # s=source, t=target, w=weight
    add_vertices(s,t)

    if @graph.has_key?(s)
      @graph[s][t] = w         
    else
      @graph[s] = { t => w }     
    end
    
    # Begin code for non directed graph (inserts the other edge too)
    # if @graph.has_key?(t)
    #   @graph[t][s] = w         
    # else
    #   @graph[t] = { s => w }     
    # end
    # End code for non directed graph (ie. deleteme if you want it directed)
  end

  def adjacency_matrix
    size = @vertices.length
    @adjacency_matrix = Array.new(size,0) { Array.new(size,0) }
    
    @adjacency_matrix.each.with_index do |row, row_index|
      row.each.with_index do |col, col_index|
        from = @vertices[row_index]
        to = @vertices[col_index]

        puts "from: #{from}, to: #{to}"
        if @graph[from] == nil
          @adjacency_matrix[row_index][col_index] = 0
        elsif @graph[from][to] != nil
          @adjacency_matrix[row_index][col_index] = 1
        else
          @adjacency_matrix[row_index][col_index] = 0
        end
      end
    end
    @adjacency_matrix
  end

  def depth_first_search
    # TODO implement solutoin traversal
  end

  def breadth_first_search
    # TODO implement solutoin traversal
  end
end


# Additional Resources:
# http://www.informit.com/articles/article.aspx?p=26943&seqNum=6
# https://dzone.com/articles/ruby-graph-dijkstra
# http://www.sitepoint.com/graph-algorithms-ruby/
