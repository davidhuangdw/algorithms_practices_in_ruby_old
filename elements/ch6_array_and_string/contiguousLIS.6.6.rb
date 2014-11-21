
module ContinuousLIS
  def lis
    return [0,-1] if self.empty?
    last = first = [0,0]
    ranges = self.each.with_index.each_cons(2).map do |x|
      pre,*,val,i = x.flatten
      last = val>pre ? [last[0],i] : [i,i]
    end.unshift(first)

    # ranges.max(&compare_range_len)
    ranges.max_by{|x| x[1]-x[0]}
  end
end