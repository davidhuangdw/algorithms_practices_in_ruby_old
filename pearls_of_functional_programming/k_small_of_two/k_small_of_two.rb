class KSmall
  def ksmall(_k, _a, _b)
    @k,@a,@b = _k,_a,_b
    raise ArgumentError unless 1<=k && k<=a.size+b.size

    @a,@b = [a,b].sort_by(&:size)
    return b[k-1] if a.empty?
    pre_eliminate
    safe_eliminate
  end

private
  attr_accessor :k,:a,:b,:pre_a,:pre_b
  def pre_eliminate
    if a.size < k
      excluded = @pre_b = b.first(k-a.size)
      eliminate(excluded)
    end
  end

  def safe_eliminate
    until k==1
      @pre_a = a.first(k/2)
      @pre_b = b.first(k-k/2)
      excluded = [pre_a, pre_b].min_by(&:last)
      eliminate(excluded)
    end
    [a.first,b.first].min
  end

  def eliminate(excluded)
    excluded === pre_a ?
      (@a = a[excluded.size..k]) :
      (@b = b[excluded.size..k])
    @k -= excluded.size
  end

end