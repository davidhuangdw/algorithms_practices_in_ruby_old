require_relative '../largest_rectangle'

describe LargestRectangle do
  subject {LargestRectangle.new(buildings)}
  let(:array) {[[1,1],
                [3,3],
                [4,4],
                [1,2],
                [2,6],
                [1,1],
                [3,2],
                [1,1]
  ]}
  let(:largest_size) {21}
  let(:buildings) {array.map{|w,h| Building.new(w,h)}}
  describe "#largest_size" do
    it "should compute the largest rectangle's size" do
      expect(subject.largest_size).to eq largest_size
    end
    context "more example" do
      let(:array) {[[1,1],
                    [3,3],
                    [4,4],
                    [1,2],
                    [2,6],
                    [1,2],
                    [3,2],
                    [1,1]
      ]}
      let(:largest_size) {28}
      it "should still right" do
        expect(subject.largest_size).to eq largest_size
      end
    end
  end
end