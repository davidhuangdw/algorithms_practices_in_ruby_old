module Rotateble
protected
  def rotate_left
    node = self.left
    self.left = node.right
    node.right = self
    update
    node.update
  end

  def rotate_right
    node = self.right
    self.right = node.left
    node.left = self
    update
    node.update
  end
end

module ImmutableRotateble
  protected
  def rotate_left
    left = self.left.left
    right = rebuild_from_children(self.left.right, self.right)
    self.left.rebuild_from_children(left,right)
  end
  def rotate_right
    right = self.right.right
    left = rebuild_from_children(self.left, self.right.left)
    self.right.rebuild_from_children(left,right)
  end
end

