require 'rspec'
require 'deque.rb'

describe MyDeque do
  subject { MyDeque.new }
  let(:a) { Node.new("a") }
  let(:b) { Node.new("b") }
  let(:c) { Node.new("c") }

  it "#push takes elements on front"
  it "#pop removes elements from front"
  it "#shift removes elements from back"
  it "#unshift adds elements to back"
end

