require_relative '../equivalence_class.6.7'

describe EquivalenceClass do
  subject {EquivalenceClass.new(7)}
  describe "#groups" do
    before do
      subject.add_equal([1,5,3,6],[2,1,0,5])
    end
    its(:groups) {should == Set.new([[0,3],[4],[1,2,5,6]])}
  end
end