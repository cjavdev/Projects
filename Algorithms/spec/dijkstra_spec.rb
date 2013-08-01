require_relative '../dijkstra.rb'
require_relative '../../DataStructures/lib/graph.rb'

describe Dijkstra do 
  let(:g) { Graph.new }
  let(:n1) { Node.new(1) }
  let(:n2) { Node.new(2) }
  let(:n3) { Node.new(3) }
  subject { Dijkstra.new(g) }
  it "finds the shortest path" do
   true.should == false 
  end
end
