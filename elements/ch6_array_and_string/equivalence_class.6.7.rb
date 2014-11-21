class UnionFindSet
  def initialize
    @anc = {}
  end
  def union!(x,y)
    if root_for(x) != root_for(y)
      @anc[root_for(x)] = root_for(y)
    end
  end
  def root_for(x)
    root?(x) ? x :
        @anc[x] = root_for(@anc[x])
  end
  def root?(x)
    @anc[x].nil? || @anc[x]==x
  end
end

require "set"
class EquivalenceClass
  attr_reader :size
  def initialize(size)
    @size = size
    @set = UnionFindSet.new
  end
  def add_equal(a, b)
    a.zip(b).each do |x,y|
      @set.union!(x,y)
    end
  end
  def groups
    Set.new (0..size-1).
                group_by {|x| @set.root_for(x)}.
                values
  end
end