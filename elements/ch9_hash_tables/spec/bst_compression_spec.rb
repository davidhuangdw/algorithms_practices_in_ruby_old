require_relative '../bst_compression.12.4'

describe Forest do
  before { @forest = Forest.new}
  describe "for one node trees" do
    before do
      order = %w{3 0 0}
      @tree = @forest.new_tree(pre_order:order)
      @other_tree = @forest.new_tree(pre_order:order)
      @third_tree = @forest.new_tree(pre_order:order)
    end
    it "should have only one node" do
      expect(@forest.nodes_count).to eq 1
      [@tree, @other_tree, @third_tree].each do |tree|
        expect(tree.nodes_count).to eq 1
      end
    end
    describe "when add a different tree" do
      before {@four = @forest.new_tree(pre_order:%w{4 0 0})}
      it "should have more than one node" do
        expect(@forest.nodes_count).to eq 2
        expect(@four.nodes_count).to eq 1
      end
    end
  end

  describe "for partial shared trees" do
    before do
      orders = [%w{3 2 1 99 0 0 0 0 0},
                %w{9 5 3 0 0 7 0 0 11 0 0},
                %w{2 1 99 0 0 0 5 3 0 0 7 0 0}]
      @trees = orders.map {|ord| @forest.new_tree(pre_order:ord)}
    end

    it "should have right number of nodes" do
      expect(@forest.nodes_count).to eq 10
      expect(@trees.map(&:nodes_count)).to eq [4,5,6]
    end
  end

end