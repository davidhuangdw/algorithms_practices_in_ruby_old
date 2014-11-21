require 'delegate'
class InversionsCount < SimpleDelegator
  def count
    @count ||= count_compute
  end

private
  attr_accessor :sum, :removed_r
  def count_compute(array=to_ary.clone)
    return 0 if array.size <= 1
    l,r = divide(array)
    count_compute(l) +
        count_compute(r) +
        count_by_merge(array,l,r)
  end

  def count_by_merge(array,l,r)
    l,r = l.to_enum,r.to_enum
    @sum,@removed_r,array = 0,0,array.clear

    loop {extract_smallest(array,l,r)}
    loop {array << l.next; @sum += removed_r;}
    loop {array << r.next}
    sum
  end

  def extract_smallest(array, l, r)
    if l.peek <= r.peek
      array << l.next
      @sum += removed_r
    else
      array << r.next
      @removed_r += 1
    end
  end

  def divide(array)
    half = (array.size+1)/2
    [array[0...half], array[half..-1]]
  end
end