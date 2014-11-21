require_relative '../binary_node'
require_relative '../treap'
require_relative '../splay'
require 'benchmark'

shared_examples_for "binary tree" do |options|
  context "afeter insert [0...10]" do
    let(:size) {10}
    let(:values) {(0...size).to_a.shuffle}
    let(:sorted) {values.sort}
    before do
      values.each {|v| subject.insert(v)}
    end
    it "should insert value" do
      expect(subject.size).to eq size
      expect(subject.to_a).to eq sorted
      sorted.each.each_with_index do |v, i|
        expect(subject[i]).to eq v
      end
    end
    describe "#lower_bound, #upper_bound" do
      let(:values) { (0...size).select(&:odd?).shuffle}
      it "should return the first/last index whose value >= a given value" do
        expect(subject.lower_bound(4)).to eq 2
        expect(subject.lower_bound(5)).to eq 2
        expect(subject.upper_bound(4)).to eq 2
        expect(subject.upper_bound(5)).to eq 2
      end
      context "when there are repeat values" do
        let(:arg_value) { 5 }
        let(:repeat)    { 3 }
        let(:lower_bound) { 2 }
        let(:upper_bound) { lower_bound+repeat }
        before { repeat.times {subject.insert(arg_value)} }
        it "should still right" do
          expect(subject.lower_bound(arg_value)).to eq lower_bound
          expect(subject.upper_bound(arg_value)).to eq upper_bound
        end
      end
    end

    context "after remove 0...5" do
      let(:removed_values) { (0...5).to_a.shuffle}
      let(:sorted_after_remove) { (values - removed_values).sort}
      before do
        removed_values.each {|v| subject.remove(v)}
        3.times do
          subject.remove(1000)
          subject.remove(-1)
        end
      end
      it "should remove values" do
        expect(subject.to_a).to eq sorted_after_remove
      end
    end
  end
end
describe BinaryTree do
  it_should_behave_like "binary tree"
end
describe TreapTree do
  it_should_behave_like "binary tree"
end
describe SplayTree do
  it_should_behave_like "binary tree"
end

describe ImmutableBinaryTree do
  it_should_behave_like "binary tree"
end
describe ImmutableTreapTree do
  it_should_behave_like "binary tree"
end
describe ImmutableSplayTree do
  it_should_behave_like "binary tree"
end

# context 'performance' do
#   let(:size) {10_1000}
#   it "should run quickly for large number insert" do
#     x = TreapTree.new
#     expect(Benchmark.realtime do
#       (0...size).each {|v| x.insert(v)}
#     end).to < 1
#   end
# end

