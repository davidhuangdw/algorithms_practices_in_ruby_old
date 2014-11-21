require_relative '../k_small_of_two'

describe KSmall do
  describe ".ksmall" do
    let(:a) {[1,2,3,5,9]}
    let(:b) {[1,3,4,5,6,7]}
    let(:k) {6}
    let(:kth) {4}
    subject {KSmall.new.ksmall(k,a,b)}
    it "should return kth smallest value for two sorted array" do
      expect(subject).to eq kth
    end
    context "when one array emtpy: 3, [1,2,3,5,9], []" do
      let(:b) {[]}
      let(:k) {3}
      let(:kth) {3}
      it {should == kth}
    end

    context "when 5, [1,3,5], [2,4,6]" do
      let(:a) {[1,3,5]}
      let(:b) {[2,4,6]}
      let(:k) {5}
      let(:kth) {5}
      it {should == kth}
    end

    context "more examples" do
      let(:a) {[1,2,3,5,9,12,13]}
      let(:b) {[1,3,4,5,6,7]}
      let(:kth) {4}
      it {should == kth}
    end
  end
end