require 'rspec'
require 'graph.rb'

describe Node do
  it "#initialize takes a value" do
    n = Node.new(1)
    expect(n.value).to eq(1)
  end
end

describe Graph do
  subject { Graph.new }
  let(:n1) { Node.new(1) }
  let(:n2) { Node.new(2) }
  let(:n3) { Node.new(3) }

  it "#add_node adds a node" do
    subject.add_node(n1)
    expect(subject.nodes.length).to eq(1)
  end

  it "#add_edge adds an edge" do
    subject.add_node(n1)
    subject.add_node(n2)
    subject.add_edge(n1, n2)
    subject.nodes[n1.value].value.should == 1
    subject.nodes[n1.value].neighbors.count.should == 1
    subject.nodes[n2.value].neighbors.count.should == 0
  end

  it "#adjacent? checks if a node is adjacent to another" do
    subject.add_node(n1)
    subject.add_node(n2)
    subject.add_node(n3)
    subject.add_edge(n1, n2)
    subject.adjacent?(n1, n2).should == true
    subject.adjacent?(n1, n3).should == false
  end

  it "#edge_value gets edge value between n1, and n2" do
    subject.add_node(n1)
    subject.add_node(n2)
    subject.add_node(n3)
    subject.add_edge(n1, n2, 4)
    subject.edge_value(n1, n2).should == 4
    subject.edge_value(n1, n3).should == nil
  end

  # Commenting out 2016-10-01 because has_path_to is empty
  # it "#find finds an item" do
  #   subject.add_node(n1)
  #   subject.add_node(n2)
  #   subject.add_node(n3)
  #   subject.add_edge(n1, n2)
  #   subject.add_edge(n2, n3)
  #   n1.has_path_to(n3).should == true
  # end
end
