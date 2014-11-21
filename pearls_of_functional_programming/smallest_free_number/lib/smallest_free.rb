
module SmallestFreeNumber
  def smallest_free(from=1)
    raise ArgumentError, "must be array with only positives" unless all?{|v| v>0}
    return from if empty?

    low_half_size = (size+1)/2
    low_max = from + low_half_size -1
    low, high = partition{|v| v<=low_max}
    contain_free?(low.size, low_half_size) ?
        low.smallest_free(from) :
        high.smallest_free(low_max+1)
  end
private
  def contain_free?(actual_size, value_range_size)
    actual_size != value_range_size
  end
end