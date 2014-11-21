require_relative '../lib/smallest_free'

describe SmallestFreeNumber do
  before { class Array; include SmallestFreeNumber; end }
  let(:range) { (1..100)}
  let(:missing) { [3,9,15,64,70]}
  let(:array) { (range.to_a - missing).shuffle}

  describe "#smallest_free" do
    subject {array.smallest_free}
    it "should return smallest positive integer not existed in an array" do
      expect(subject).to eq 3
    end
    context "when empty" do
      let(:array) { [] }
      specify { expect(subject).to eq 1 }
    end

    context "when [2]" do
      let(:array) { [2] }
      it {should == 1}
    end

    context "when odd size array [4,8,3,1,2]" do
      let(:array) {[4,8,3,1,2]}
      it {should == 5}
    end

    context "when even size array [4,5,3,10,1,2]" do
      let(:array) {[4,5,3,10,1,2]}
      it {should == 6}
    end
    context "when array from 0 to 1000_000" do
      let(:range) { 1..1000_000}
      let(:missing) {[12345, 54321]}
      it {should == 12345}
    end
  end

end