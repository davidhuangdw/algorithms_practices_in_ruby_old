require_relative 'binary_node'
require_relative 'rotateble'

class TreapNullNode < NullNode
  def creator; TreapNode; end
  def priority; 1; end
  def ordered_node; self; end
end

class ImmutableTreapNullNode < TreapNullNode
  def creator; ImmutableTreapNode; end
end

module Treapable
  attr_reader :priority, :height
  def initialize(value, left=null_node, right=null_node, priority=random_float)
    super(value,left,right)
    @priority = priority
  end
  def insert(value)
    super.ordered_node
  end
  def remove(value)
    super.ordered_node
  end
  protected
  def ordered_node
    return self if right_order?
    left.priority < right.priority ?
        rotate_left :
        rotate_right
  end
  private
  def right_order?
    priority <= [left.priority, right.priority].min
  end
  def null_node
    TreapNullNode.instance
  end
  def random_float
    Random.rand
  end
end

class TreapNode < BinaryNode
  include Treapable
  include Rotateble
end

class TreapTree < BinaryTree
private
  def null_node; TreapNullNode.instance; end
end

class ImmutableTreapNode < BinaryNode
  include ImmutableNodeModule
  include ImmutableRotateble
  include Treapable
private
  def null_node; ImmutableTreapNullNode.instance; end
end

class ImmutableTreapTree < BinaryTree
  private
  def null_node; ImmutableTreapNullNode.instance; end
end
