require 'delegate'

class LongestSubarray < SimpleDelegator
  attr_reader :bound
  def initialize(array,bound)
    @bound = bound
    super(Array(array))
  end

  def longest
    @longest ||= compute_longest
  end

private
  attr_accessor :longest_range
  def compute_longest
    @longest_range = (0...0)
    lenum,renum = [(0...size),possible_right].map(&:to_enum)
    loop { update(lenum,renum) }
    self[longest_range]
  end

  def update(left,right)
    l,r = [left,right].map(&:peek)
    if l<=r && sum(l,r) <= bound
      @longest_range = [longest_range, (l..r)].max_by(&:size)
      right.next
    else
      left.next
    end
  end

  def possible_right
    @possible_right ||= compute_possible_right
  end

  def compute_possible_right
    result = [size-1]
    while (pos = left_inc_pos_for(result.last)-1) >= 0
      result << pos
    end
    result.reverse!
  end

  def left_inc_pos_for(i)
    (0..i).reverse_each.find {|l| sum(l,i)>0} || -1
  end

  def sum(l,r)
    pre_sum[r+1] - pre_sum[l]
  end

  def pre_sum
    @pre_sum ||= compute_pre_sum
  end

  def compute_pre_sum
    last =0
    [0] + self.map { |v| last += v}
  end
end