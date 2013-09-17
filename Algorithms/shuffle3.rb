require 'rgl/adjacency'


g = RGL::DirectedAdjacencyGraph.new

p g


students = [:oddalot,
            :persamina,
            :djquan,
            :RussHR,
            :jsrosen3,
            # :amtrakcn,
            # "giant-squid",
            # :jsinghdreams,
            # :atseng3,
            # :justalisteningman,
            # :Zehhu,
            # :bwarkee,
            # :aarnwri,
            # :guillewu,
            # :dyang12,
            # :izhou,
            # :vpark,
            :tnd23 ]

students.combination(2).each do |pair|
  g.add_edge(pair.first, pair.last, 6)
end
p g


