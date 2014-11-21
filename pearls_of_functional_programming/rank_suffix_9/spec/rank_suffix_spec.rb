require_relative '../rank_suffix'

shared_examples_for "rankable" do
    it "should compute each value's rank" do
      expect(subject.rank).to eq rank
    end
end

describe ArrayRank do
  let(:array) {[51,38,29,51,63,38]}
  let(:rank) {[3,1,0,3,5,1]}
  subject {ArrayRank.new(array)}
  describe "#rank" do
    it_should_behave_like "rankable"
  end
end

describe SuffixRank do
  let(:array) {"abab"}
  let(:rank) {[1,3,0,2]}
  subject {SuffixRank.new(array)}
  describe "#rank" do
    it_should_behave_like "rankable"
    context "more examples" do
      let(:array) { [1,3,4,2,3]}
      let(:rank) {[0,3,4,1,2]}
      it_should_behave_like "rankable"
    end
  end
end
