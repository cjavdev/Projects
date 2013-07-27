require_relative '../hash.rb'

describe MyHash do
  subject { MyHash.new }
  it "inserts items" do
    subject["test"] = "this is a test"
    subject["test"].should == "this is a test"
  end

  it "removes items" do
    subject["test"] = "this is a test"
    subject.remove("test")
    subject["test"].should == nil
  end

  it "doubles bucket sizes" do
    subject["test1"] = "test1"
    subject["apple"] = "test2"
    subject["banana"] = "test3"
    subject["grape"] = "test4"
    subject["bottle"] = "test5"
    subject["marker"] = "test6"
    subject["computer"] = "test7"
    subject["laptop"] = "test8"
    subject["macbook"] = "test9"

    subject["retna"] = "test10"
    subject["chair"] = "test11"
    old_bucket_length = subject.buckets.length
    
    10.times do |x|
      subject[ "test#{ x }" ] = "test#{ x }"
    end
    p subject.buckets
    subject.buckets.length.should == 2*old_bucket_length
  end

  it "prints shit" do
    subject["apple"] = "new"
    subject["another test"] = "blah"

    subject.each do |key, value|
      puts "#{ key }: #{ value }"
    end
  end
end
