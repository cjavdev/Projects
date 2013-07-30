require 'rspec'
require 'graph.rb'

describe Node do
  it "#initialize takes a value" do
    n = Node.new(1)
    n.value.should == 1
  end
end

describe Graph do
  subject { Graph.new }
  let(:n1) { Node.new(1) }
  let(:n2) { Node.new(2) }

  it "#add_node adds a node" do
    subject.add_node(n1)
    subject.nodes.length.should == 1
  end

  it "#add_edge adds an edge" do
    subject.add_node(n1)
    subject.add_node(n2)
    subject.add_edge(n1, n2)
    subject.nodes[n1.value].value.should == 1
    subject.nodes[n1.value].neighbors.count.should == 1
    subject.nodes[n2.value].neighbors.count.should == 0
  end
end
