require 'delegate'
class ArrayRank < SimpleDelegator
  def initialize(array)
    super(get_array(array))
  end

  def rank
    @rank ||= compute_rank
  end

  private
  def get_array(array)
    case array
      when Array; array
      when String; array.chars
      else; array.to_ary
    end
  end

  def sorted_indexes
    @sorted_index ||= (0...size).sort_by{|i| self[i]}
  end

  def sorted
    @sorted ||= sorted_indexes.map{|i| self[i]}
  end

  def compute_rank
    accumulate_repeat tight_rank
  end

  def tight_rank
    tight_rank = tight_rank_for_sorted(sorted)
    reorder_for(tight_rank, from:sorted_indexes)
  end

  def reorder_for(values, from:)
    result = []
    values.zip(from) {|v,i| result[i] = v }
    result
  end

  def tight_rank_for_sorted(values)
    pre,rank = nil,-1
    values.map do |v|
      pre,v = v,pre
      rank += (pre==v ? 0:1)
    end
  end

  def accumulate_repeat(ranks)
    pre_count = accumulate_count(count(ranks))
    ranks.map {|r| r==0 ? 0:pre_count[r-1]}
  end

  def count(ranks)
    count = (0..ranks.max).map{0}
    ranks.each { |r| count[r]+=1 }
    count
  end

  def accumulate_count(count)
    (1...count.size).each {|i| count[i]+=count[i-1]}
    count
  end
end

