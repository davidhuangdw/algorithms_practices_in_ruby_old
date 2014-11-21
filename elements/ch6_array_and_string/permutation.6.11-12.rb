require 'forwardable'

class Permutation
  attr_reader :perm
  def initialize(perm)
    raise ArgumentError,
          "invalid permutation #{perm}" unless permutation?(perm)
    @perm = perm
  end

  include Enumerable
  extend Forwardable
  def_delegators :@perm, :[], :each, :size

  def invert
    Permutation.new invert_permutation_array
  end

  def next
    Permutation.new next_permutation_array
  end

  def ==(other)
    perm == other.perm
  end

private
  def invert_permutation_array
    invert = []
    self.each.with_index { |v, i| invert[v] = i }
    invert
  end
  def next_permutation_array
    pos = last_index_less_than_suffix
    pos ? swap_and_reverse_after(pos) : perm.reverse
  end
  def last_index_less_than_suffix
    (0..size-2).
        find_all{|i| perm[i]<perm[i+1]}.
        last
  end
  def swap_and_reverse_after(pos)
    # "...387521" => "...512378"
    pre,val,suf = perm[0..pos-1],perm[pos],perm[pos+1..-1]
    suf.reverse!

    gt_pos = suf.find_index{|x| x>val}
    val,suf[gt_pos] = suf[gt_pos],val

    pre+[val]+suf
  end
  def permutation?(perm)
    return false unless perm.all? {|x| (0..perm.size-1).include?(x)}
    perm.uniq.size == perm.size
  end
end