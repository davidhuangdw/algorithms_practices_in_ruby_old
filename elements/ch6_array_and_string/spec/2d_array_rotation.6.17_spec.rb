require_relative '../2d_array_rotation.6.17'

describe SquareArray do
  let(:array) {(1..16).each_slice(4).to_a}
  subject {SquareArray.new(array)}

  describe "#rotate!" do
    let(:result) {[[13,9,5,1],
                   [14,10,6,2],
                   [15,11,7,3],
                   [16,12,8,4]]}
    it "should rotate 90 degree" do
      subject.rotate!
      expect(subject.array).to eq result
    end
  end
end