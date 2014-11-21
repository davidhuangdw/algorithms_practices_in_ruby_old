require_relative 'drawing_skyline'

class SkylineComputeByMerge < SimpleDelegator

  def compute(segments=building_segments)
    return segments if segments.size <= 1
    l,r = divide(segments)
    join_adjacent merge(compute(l),compute(r))
  end

private
  def divide(segments)
    half = (segments.size+1)/2
    [segments.first(half), segments[half..-1]]
  end

  def merge(left, right)
    left,right = left.to_enum,right.to_enum
    result = []
    loop { result << extract_first(left, right) }
    loop { result << left.next}
    loop { result << right.next}
    result
  end

  def extract_first(left, right)
    left,right = [left,right].sort_by(&:peek)
    ls,rs = [left,right].map(&:peek)

    return left.next if separated?(ls, rs)
    overlap_at_begin?(ls,rs) ?
        extract_first_overlap(left, right, ls, rs) :
        extract_first_unoverlap(ls,rs)
  end

  def extract_first_overlap(left,right,ls,rs)
    ls.height = [ls.height,rs.height].max
    ls.right == rs.right ?
        right.next :
        rs.left = ls.right
    left.next
  end

  def extract_first_unoverlap(ls,rs)
    result = create_segment(ls.left,rs.left,ls.height)
    ls.left = rs.left
    result
  end

  def overlap_at_begin?(ls, rs)
    ls.left == rs.left
  end

  def separated?(ls, rs)
    ls.right <= rs.left
  end

end

