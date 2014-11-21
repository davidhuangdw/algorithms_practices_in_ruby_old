require_relative 'array_rank'
class SuffixRank < ArrayRank
  def suffix(i)
    self[i..-1]
  end

  def rank_pair_suffix
    (0...size).map {|i| [rank[i],suffix(i)]}
  end

private

  def compute_rank
    rank,index_order,len = tight_rank,sorted_indexes,1
    until compute_complete?(len,rank)
      rank,index_order,len =
          double_length_update(rank, index_order, len)
    end
    accumulate_repeat rank
  end

  def compute_complete?(len,rank)
    len*2 > size || rank.max >= size-1
  end

  def double_length_update(rank,indexes,half_len)
    indexes = bucket_sort second_half_order(indexes,half_len),rank
    values = indexes.map{|i| [rank[i], rank[i+half_len]]}
    rank = reorder_for tight_rank_for_sorted(values), from:indexes
    [rank,indexes,half_len*2]
  end

  def second_half_order(first_half_order, half_len)
    null_ones = (size-half_len...size).to_a
    same_order = first_half_order.map{|i| i-half_len}.select{|i| i>=0}
    null_ones + same_order
  end

  def bucket_sort(order, pos)
    buckets = (0..pos.max).map{[]}
    order.each {|i| buckets[pos[i]] << i}
    buckets.flatten
  end
end
