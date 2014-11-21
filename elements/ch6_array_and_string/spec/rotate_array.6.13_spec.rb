require_relative '../rotate_array.6.13'

describe Rotateble do
  subject do
    array.singleton_class.class_eval do
      include Rotateble5
    end
    array.rotate_strategy = RotateByReverse.new
    array
  end

  describe "#my_rotate!" do
    let(:array) { [1,2,3,4,5,6] }
    let(:dis) { 4 }
    it "should rotate the specific distance" do
      subject.my_rotate!(dis)
      expect(subject).to eq [5,6,1,2,3,4]
    end
    context "when distance is zero" do
      let(:dis) { 0 }
      it "should not change" do
        subject.my_rotate!(dis)
        expect(subject).to eq array
      end
    end
    context "when distance is longer than size" do
      let(:dis) { 10 }
      it "should rotate the specific distance" do
        subject.my_rotate!(dis)
        expect(subject).to eq [5,6,1,2,3,4]
      end
    end
    context "when array is empty" do
      let(:array) { [] }
      it "should not change"  do
        subject.my_rotate!(dis)
        expect(subject).to eq []
      end
    end
  end
end