require_relative '../longest_nondescreasing'

shared_examples_for "#longest_size" do
  describe "#longest_size" do
    it "should compute the size of longest nondescreasing subarray" do
      expect(subject.longest_size).to eq longest.size
    end
    context "when all nondescreasing" do
      let(:array) {[1]*5}
      it "shoud return whole size" do
        expect(subject.longest_size).to eq array.size
      end
    end
  end
end

describe LongestNondescreasing do
  subject {LongestNondescreasing.new(array)}
  let(:array) {[0,8,4,12,2,10,6,14,1,9]}
  let(:longest) {[0,4,10,14]}
  it_should_behave_like "#longest_size"
end

describe LongestDetail do
  subject {LongestDetail.new(array)}
  let(:array) {[0,8,4,12,2,10,6,14,1,9]}
  let(:longest) {[0,2,6,14]}
  let(:all_longest) {[[0,2,6,14], [0,2,6,9]]}
  it_should_behave_like "#longest_size"
  describe "#longest" do
    it "should compute the first longest nondescreasing subarray" do
      expect(subject.longest).to eq longest
    end
  end
  describe "#all_longest" do
    it "should compute all of longest nondescreasing subarrays with different end" do
      expect(subject.longest).to eq longest
    end
  end
end
