require 'delegate'

class LongestNondescreasing < SimpleDelegator
  def longest_size
    @longest_size ||= compute_longest_size
  end

private

  def compute_longest_size
    t = smallest_end_for_length = []
    each do |v|
      pos = (0...t.size).bsearch{|i| t[i]>v} || t.size
      t[pos] = v
    end
    smallest_end_for_length.size
  end
end


class LongestDetail < LongestNondescreasing
  def longest
    @longest ||= compute_first_longest
  end

  def all_longest
    @all_longest ||= compute_all_longest
  end

  def longest_size
    longest.size
  end

private
  Info = Struct.new(:pre, :length)
  attr_writer :longest_info

  def compute_all_longest
    (0...size).
        select{|i| longest_info[i].length==longest_size}.
        map{|i| sequence_from_last_index(i) }
  end

  def compute_first_longest
    sequence_from_last_index (0...size).max_by{|i| longest_info[i].length}
  end

  def sequence_from_last_index (i)
    sequence_by_iterate(i)
    # sequence_by_recur(i)
  end

  def sequence_by_iterate (i)
    seq = []
    while i
      seq.unshift self[i]
      i = longest_info[i].pre
    end
    seq
  end

  def sequence_by_recur (i)
    i ? (sequence_by_recur(longest_info[i].pre) << self[i]) : []
  end

  def longest_info
    @longest_info ||= compute_longest_info
  end

  def compute_longest_info
    t = smallest_end_for_length = []
    (0...size).map do |i|
      pos = (0...t.size).bsearch{ |j| self[t[j]] > self[i] } || t.size
      pre,t[pos] = (pos==0?nil:t[pos-1]),i
      create_info(pre, pos+1)
    end
  end

  def create_info(*args)
    Info.new(*args)
  end
end
