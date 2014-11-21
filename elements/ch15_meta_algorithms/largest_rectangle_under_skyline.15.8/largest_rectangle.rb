require 'delegate'

Building = Struct.new(:width,:height)

class LargestRectangle < SimpleDelegator
  def largest_size
    largest.size
  end
  def largest
    @largest ||= compute_largest
  end

  def width_sum(l,r)
    pre_sum(r+1)-pre_sum(l)
  end

private
  Info = Struct.new(:left, :right, :height, :context) do
    def size
      context.width_sum(left, right)*height
    end
  end

  def compute_largest
    (0...size).map do |i|
      create_info(prev_lower[i]+1, succ_lower[i]-1, self[i].height, self)
    end.max_by(&:size)
  end

  def prev_lower
    @prev_lower ||= compute_prev_lower
  end

  def succ_lower
    @succ_lower ||= compute_succ_lower
  end

  def compute_prev_lower
    stack = []
    (0...size).map do |i|
      pop_highers_from(stack,i)
      stack[-2] || -1
    end
  end

  def compute_succ_lower
    stack = []
    (0...size).reverse_each.map do |i|
      pop_highers_from(stack,i)
      stack[-2] || size
    end.reverse!
  end

  def pop_highers_from(stack, i)
    h = self[i].height
    stack.pop until stack.empty? || self[stack.last].height < h
    stack << i
  end

  def pre_sum(num)
    @pre_sum ||= compute_pre_sum
    @pre_sum[num]
  end

  def compute_pre_sum
    last=0
    [0] + map{|building| last += building.width}
  end

  def create_info(*args)
    Info.new(*args)
  end
end