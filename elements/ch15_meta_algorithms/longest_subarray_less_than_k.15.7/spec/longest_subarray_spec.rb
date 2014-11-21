require_relative '../longgest_subarray'

describe LongestSubarray do
  let(:array) {[431, -15, 639, 342, -14, 565, -924, 635, 167, -70]}
  let(:bound) {184}
  subject {LongestSubarray.new(array,bound)}
  it "should compute the longest subarray whose sum <= bound" do
    expect(subject.longest).to eq array[3..6]
  end
  context "when no result" do
    let(:bound) {-1000}
    it "should return []" do
      expect(subject.longest).to eq array[0...0]
    end
  end

  context "when all negative" do
    let(:array) {[-1,-2,-3,-12,-2]}
    it "should return all or none" do
      expect(subject.longest).to eq array
    end
  end
end