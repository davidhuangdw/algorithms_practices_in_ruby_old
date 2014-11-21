require_relative '../contiguousLIS.6.6'

class Array
  include ContinuousLIS
end

describe ContinuousLIS do
  describe "#lis" do
    context "when empty array" do
      subject {[]}
      its(:lis) {should == [0,-1]}
    end
    context "when single array" do
      subject {[1]}
      its(:lis) {should == [0,0]}
    end
    context "when normal array" do
      subject {[9,9,9,9,4,5,6,7,0,9,10,11]}
      its(:lis) {should == [4,7]}
    end
    context "when with repitition" do
      subject {[9,9,9,9,4,5,6,6,7,0,0,0,0]}
      its(:lis) {should == [4,6]}
    end
  end
end