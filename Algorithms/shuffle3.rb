require 'rgl/adjacency'

# A weighted undirected graph.
class WeightedUnDirectedGraph < RGL::AdjacencyGraph
  def initialize(edgelist_class = Set, *other_graphs)
    super
    @weights = {}
  end

  # Create a graph from an array of [source, target, weight] triples.
  #
  #  >> g=EditAlign::WeightedDirectedGraph[:a, :b, 2, :b, :c, 3, :a, :c, 6]
  #  >> puts g
  #  (a-2-b)
  #  (a-6-c)
  #  (b-3-c)
  def self.[] (*a)
    result = new
    0.step(a.size-2, 3) { |i| result.add_edge(a[i], a[i+1], a[i+2]) }
    result
  end

  def to_s
    # TODO Sort toplogically instead of by edge string.
    (edges.sort_by {|e| e.to_s} +
     isolates.sort_by {|n| n.to_s}).map { |e| e.to_s }.join("\n")
  end

  # A set of all the unconnected vertices in the graph.
  def isolates
    edges.inject(Set.new(vertices)) { |iso, e| iso -= [e.source, e.target] }
  end

  # Add a weighted edge between two verticies.
  #
  # [_u_] source vertex
  # [_v_] target vertex
  # [_w_] weight
  def add_edge(u, v, w)
    super(u,v)
    @weights[[u,v]] = w
  end

  # Edge weight
  #
  # [_u_] source vertex
  # [_v_] target vertex
  def weight(u, v)
    @weights[[u,v]]
  end

  # Remove the edge between two verticies.
  #
  # [_u_] source vertex
  # [_v_] target vertex
  def remove_edge(u, v)
    super
    @weights.delete([u,v])
  end

  # The class used for edges in this graph.
  def edge_class
    WeightedUnDirectedEdge
  end

  # Return the array of WeightedDirectedEdge objects of the graph.
  def edges
    result = []
    c = edge_class
    each_edge { |u,v| result << c.new(u, v, self) }
    result
  end

end


# A directed edge that can display its weight as part of stringification.
class WeightedUnDirectedEdge < RGL::Edge::UnDirectedEdge

  # [_u_] source vertex
  # [_v_] target vertex
  # [_g_] the graph in which this edge appears
  def initialize(a, b, g)
    super(a,b)
    @graph = g
  end

  # The weight of this edge.
  def weight
    @graph.weight(source, target)
  end

   def to_s
     "(#{source}-#{weight}-#{target})"
   end
end
g = WeightedUnDirectedGraph.new
p g
students = [ :oddalot, :persamina, :djquan, :RussHR, :jsrosen3, :amtrakcn,
        "giant-squid", :jsinghdreams, :atseng3, :justalisteningman,
        :Zehhu, :bwarkee, :aarnwri, :guillewu, :dyang12, :izhou, :vpark, :tnd23 ]

students.combination(2).each do |pair|
  g.add_edge(pair.first, pair.last, 6)
end
p g