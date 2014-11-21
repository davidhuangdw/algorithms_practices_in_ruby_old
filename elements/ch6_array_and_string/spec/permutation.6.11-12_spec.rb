require_relative '../permutation.6.11-12'

describe Permutation do
  let(:perm) { [4,3,1,0,2,5] }
  subject {Permutation.new(perm)}

  describe "#initialize" do
    context "with an invalid permutation" do
      let(:perm) { [1,4,5] }
      specify { expect{subject}.to raise_error(ArgumentError) }
    end
    context "with valid permutation" do
      let(:perm) { [4,3,1,0,2,5] }
      specify { expect{subject}.not_to raise_error }
    end
  end

  describe "#invert" do
    let(:invert) { [3,2,4,1,0,5] }
    its(:invert) { is_expected.to eq Permutation.new(invert)}
  end
  describe "#next" do
    let(:perm) { [5,0,2,4,3,1]}
    let(:nxt)  { [5,0,3,1,2,4] }
    its(:next) { is_expected.to eq Permutation.new(nxt)}

    context "when already last permutation" do
      let(:perm) { [3,2,1,0] }
      let(:nxt)  { [0,1,2,3]}
      its(:next) { is_expected.to eq Permutation.new(nxt)}
    end
    context "when only one element" do
      let(:perm) { [0] }
      let(:nxt)  { [0] }
      its(:next) { is_expected.to eq Permutation.new(nxt)}
    end
  end
end