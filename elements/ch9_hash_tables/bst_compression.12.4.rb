class BinaryTreeNode
  attr_accessor :nodes_count, :hash, :left, :right, :key
  def initialize(key:nil, left:nil, right:nil)
    raise SyntaxError unless key && key.class == Fixnum
    @left = left
    @right = right
    @nodes_count = 1 + self.class.count(node:left) + self.class.count(node:right);
    @hash = self.class.hash(key:key, left:left, right:right)
  end

  def self.count(node:nil)
    node.nil? ? 0 : node.nodes_count
  end

  def self.hash(key:nil, left:nil, right:nil)
    raise SyntaxError unless key && key.class == Fixnum
    3*key + 7*child_hash(node:left) + 5*child_hash(node:right);
  end

  def self.child_hash(node:nil)
    node.nil? ? 1 : node.hash
  end

end

class Forest
  attr_reader :nodes_count
  def initialize
    @nodes_count = 0
    @hash_to_tree = {}
  end

  def new_tree (pre_order:nil)
    raise SyntaxError if pre_order.nil? || pre_order.empty?
    key = pre_order[0].to_i
    return nil if key==0
    used = 1
    left = new_tree pre_order:pre_order[used..-1]

    used += (BinaryTreeNode.count(node:left)*2+1)
    right = new_tree pre_order:pre_order[used..-1]
    hash = BinaryTreeNode.hash(key:key,left:left,right:right)

    if @hash_to_tree[hash].nil?
      @nodes_count += 1
      @hash_to_tree[hash] = BinaryTreeNode.new(key:key, left:left, right:right)
    else
      @hash_to_tree[hash]
    end

  end
end