require_relative '../drawing_skyline'
require_relative '../scan_strategy'
require_relative '../merge_strategy'

shared_examples_for "Drawing skyline" do
  let(:buildings) {[[0,3,1],
                    [1,6,3],
                    [4,8,4],
                    [5,9,2],
                    [7,14,3],
                    [10,12,6],
                    [11,17,1],
                    [13,16,2]
  ].shuffle}
  let(:lines) {[[0,1,1],
                [1,4,3],
                [4,8,4],
                [8,10,3],
                [10,12,6],
                [12,14,3],
                [14,16,2],
                [16,17,1]
  ].
      map{|tri| Segment.new(*tri)} }
  describe "#skylines" do
    it "should compute skylines" do
      expect(subject.skylines).to eq lines
    end
    context "when building not contingous" do
      let(:buildings) {[[0,3,1],
                        [1,6,3],
                        [4,8,4],
                        [5,9,2],
                        [10,12,6],
                        [11,17,1],
                        [13,16,2]
      ].shuffle}
      let(:lines) {[[0,1,1],
                    [1,4,3],
                    [4,8,4],
                    [8,9,2],
                    [10,12,6],
                    [12,13,1],
                    [13,16,2],
                    [16,17,1]
      ].
          map{|tri| Segment.new(*tri)} }
      it "should compute skylines" do
        expect(subject.skylines).to eq lines
      end
    end
  end
end

describe SkylineComputeByScan do
  subject {DrawingSkyline.new(buildings, SkylineComputeByScan)}
  it_should_behave_like "Drawing skyline"
end

describe SkylineComputeByMerge do
  subject {DrawingSkyline.new(buildings, SkylineComputeByMerge)}
  it_should_behave_like "Drawing skyline"
end

