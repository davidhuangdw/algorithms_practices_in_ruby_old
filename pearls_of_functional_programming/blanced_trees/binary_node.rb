require 'singleton'
class NullNode
  include Singleton
  def size; 0; end
  def height; 0; end
  def nil?; true; end
  def each; ; end
  def find_node(value); nil; end
  def insert(value)
    creator.new(value)
  end
  def remove(value)
    self
  end
  def lhs_count(value); 0; end
  def creator; BinaryNode; end
private
  def lsh_count(value, &blk); 0; end
end

class ImmutableNullNode < NullNode
  def creator; ImmutableNode; end
end

class BinaryNode
  attr_reader :value, :left, :right, :size, :height
  def initialize(value, left=null_node, right=null_node)
    @value = value
    @left = left
    @right = right
    @size = compute_size
    @height = compute_height
  end

  def [](k)
    raise ArgumentError unless (0...size).include? k
    return value if k == left.size
    k<left.size ? left[k] : right[k-left.size-1]
  end

  def lower_bound(value)
    lhs_count(value, &:<)
  end

  def upper_bound(value)
    [lhs_count(value, &:<=)-1,lower_bound(value)].max
  end

  def find_node(value)
    return self if self.value == value
    ch = value < self.value ? left : right
    ch.find_node(value)
  end

  include Enumerable
  def each(&blk)
    left.each(&blk)
    blk.call(value)
    right.each(&blk)
  end

  def first
    left.nil? ? self : left.first
  end

  def last
    right.nil? ? self : right.last
  end

  def insert(value)
    self.children = children_after(:insert, value)
    update
  end

  def remove(value)
    return remove_self if self.value == value
    self.children = children_after(:remove, value)
    update
  end

protected
  attr_writer :value, :left, :right
  def update
    @size = compute_size
    @height = compute_height
    self
  end
  def children=(children)
    self.left,self.right = children
  end
private
  attr_writer :size, :height
  def null_node
    NullNode.instance
  end
  def remove_self
    return null_node if left.nil? && right.nil?
    # left,right,mid=self.left,self.right,nil
    if left.nil?
      self.value = right.first.value
      self.right = right.remove(self.value)
    else
      self.value = left.last.value
      self.left = left.remove(self.value)
    end
    self
  end
  def children_after(operate, value)
    left,right=self.left,self.right
    value < self.value ?
        left = left.send(operate,value) :
        right = right.send(operate,value)
    [left,right]
  end
  def compute_size
    1+left.size+right.size
  end
  def compute_height
    1 + [left.height, right.height].max
  end
  def create_node
    @create_node ||= ->(*args){self.class.new(*args)}
  end
  def creator
    self.class
  end

protected
  def lhs_count(value, &compare)
    compare.call(self.value, value) ?
        right.lhs_count(value, &compare) + left.size + 1 :
        left.lhs_count(value, &compare)
  end
end

require 'forwardable'
class BinaryTree
  attr_reader :root
  def initialize
    @root = null_node
    @creator = null_node.creator
  end

  def insert(value)
    self.root = root.insert(value)
  end
  def remove(value)
    self.root = root.remove(value)
  end

  extend Forwardable
  include Enumerable
  def_delegators :@root, :size, :height, :[], :each, :find_node, :lower_bound, :upper_bound

private
  attr_writer :root
  def null_node
    NullNode.instance
  end
  def create_on_root
    @create_on_root ||= ->(*args) {self.root = @creator.new(*args)}
  end

  def create_node
    @create_node ||= ->(*args){@creator.new(*args)}
  end
end

module ImmutableNodeModule
  def insert(value)
    rebuild_from_children *children_after(:insert, value)
  end

  def remove(value)
    return remove_self if self.value == value
    l,r = children_after(:remove, value)
    [l,r] == [left,right] ?
        self : rebuild_from_children(l,r)
  end
protected
  def rebuild_from_children(left, right)
    creator.new(self.value,left,right)
  end
private
  def remove_self
    return null_node if self.left.nil? && self.right.nil?
    left,right,mid=self.left,self.right,nil
    if left.nil?
      mid = creator.new(right.first.value)
      right = right.remove(mid.value)
    else
      mid = creator.new(left.last.value)
      left = left.remove(mid.value)
    end
    mid.rebuild_from_children left,right
  end
  def null_node
    ImmutableNullNode.instance
  end
end

class ImmutableNode < BinaryNode
  include ImmutableNodeModule
end

class ImmutableBinaryTree < BinaryTree
  def null_node; ImmutableNullNode.instance; end
end


