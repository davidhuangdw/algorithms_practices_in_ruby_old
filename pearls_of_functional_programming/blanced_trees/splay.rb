require_relative 'binary_node'
require_relative 'rotateble'

class SplayNullNode < NullNode
  def creator; SplayNode; end
end

class ImmutableSplayNullNode < NullNode
  def creator; ImmutableSplayNode; end
end

module Splayable
  def insert(value)
    creator.new(value, *split(lower_bound(value)))
  end
  def remove(value)
    return self unless find_node(value)
    splayed = splay(lower_bound(value))
    join(splayed.left, splayed.right)
  end

  def splay(i)
    raise ArgumentError unless 0<=i && i<size
    return self if i==left.size
    if i < left.size
      self.left = left.splay(i)
      # don't worry about update: happen in rotate_left
      rotate_left
    else
      self.right = right.splay(i-left.size-1)
      rotate_right
    end
  end

  protected
  def join(l,r)
    return l if r.nil?
    return r if l.nil?

    r = r.splay(0)
    r.left = l
    r.update
  end

  def split(pos)
    return self,null_node if pos >= size
    splayed = splay(pos)
    left = splayed.left
    splayed.left = null_node
    splayed.update
    [left, splayed]
  end
  private
  def null_node; SplayNullNode.instance; end
end

class SplayNode < BinaryNode
  include Rotateble
  include Splayable
end

class SplayTree < BinaryTree
private
  def null_node; SplayNullNode.instance; end
end

class ImmutableSplayNode < BinaryNode
  include ImmutableNodeModule
  include ImmutableRotateble
  include Splayable
  def splay(i)
    raise ArgumentError unless 0<=i && i<size
    return self if i==left.size
    i < left.size ?
        rebuild_from_children(left.splay(i),right).rotate_left :
        rebuild_from_children(left,right.splay(i-left.size-1)).rotate_right
  end
protected
  def join(l,r)
    return l if r.nil?
    return r if l.nil?

    r = r.splay(0)
    r.rebuild_from_children l,r.right
  end

  def split(pos)
    return self,null_node if pos >= size
    splayed = splay(pos)
    [splayed.left,
     splayed.rebuild_from_children(null_node,splayed.right)]
  end
private
  def null_node; ImmutableSplayNullNode.instance; end
end

class ImmutableSplayTree < BinaryTree
  private
  def null_node; ImmutableSplayNullNode.instance; end
end
