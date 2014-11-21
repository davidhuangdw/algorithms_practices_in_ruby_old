module Swapable
  def swap!(i,j)
    self[i],self[j] = self[j],self[i]
  end
end

module Reversable
  include Swapable
  def reverse_for!(range)
    range = positive_range(range)
    range.each do |i|
      j = range.end-(i-range.begin)
      break if i>=j
      swap!(i,j)
    end
  end
private
  def positive_range(range)
    positive_index(range.begin)..
        positive_index(range.end)
  end
  def positive_index(i)
    i >= 0? i : i+size
  end
end

module Rotateble
  def my_rotate!(distance=1)
    return self if self.empty?

    distance %= size
    reverse!
    reverse_for!(0..-distance-1)
    reverse_for!(-distance..-1)
    self
  end
private
  include Reversable
end

module Rotateble2
  include Swapable
  def my_rotate!(distance=1)
    return self if self.empty?

    distance %= size
    cycle = distance.gcd(size)
    hops = size/cycle
    rotate_group = ->(offset) {
      (hops-1).times.each do
        nxt=(offset+distance)%size
        swap!(offset,nxt)
        offset=nxt
      end
    }
    (0..cycle-1).map(&rotate_group)
  end
end

require 'forwardable'
class RotateMethod
  attr_reader :array
  def initialize(array)
    @array=array
  end

  def my_rotate!(distance=1)
    return array if empty?

    distance %= array.size
    @distance = distance
    cycle = distance.gcd(size)
    @hops = size/cycle
    (0..cycle-1).map(&rotate_group)
    array
  end

private
  extend Forwardable
  def_delegators :@array, :size, :swap!, :empty?
  def rotate_group
    ->(offset) do
      (@hops-1).times.each do
        nxt=(offset+@distance)%size
        swap!(offset,nxt)
        offset=nxt
      end
    end
  end
end

module Rotateble3
  include Swapable
  def my_rotate!(distance=1)
    RotateMethod.new(self).my_rotate!(distance)
  end
end

module Rotateble4
  include Swapable
  def my_rotate!(distance=1)
    return self if self.empty?

    distance %= size
    cycle = distance.gcd(size)
    hops = size/cycle
    context = {hops:hops, distance:distance}
    (0..cycle-1).each do |offset|
      rotate_group(offset, **context)
    end
  end
  def rotate_group(offset, **context)
    (context[:hops]-1).times.each do
      nxt=(offset+context[:distance])%size
      swap!(offset,nxt)
      offset=nxt
    end
  end
end

class RotateByCycle
  # dependent: swapable array
  def rotate!(array, distance=1)
    return array if array.empty?
    distance %= array.size

    @array = array
    @size = @array.size
    @distance = distance

    cycle = distance.gcd(@size)
    @hops = @size/cycle
    (0..cycle-1).each do |offset|
      rotate_group(offset)
    end
    @array
  end
  def rotate_group(offset)
    (@hops-1).times.each do
      nxt = (offset+@distance)%@size
      @array.swap!(offset,nxt)
      offset=nxt
    end
  end
end

class RotateByReverse
  # dependent: reversable array
  def rotate!(array, distance=1)
    return array if array.empty?

    distance %= array.size
    array.reverse_for!(0..distance-1)
    array.reverse_for!(distance..-1)
    array.reverse!
  end
end

module Rotateble5
  attr_accessor :rotate_strategy
  include Reversable, Swapable
  def my_rotate!(distance=1)
    rotate_strategy.rotate!(self, distance)
  end
  # def rotate_strategy
  #   @rotate_strategy ||= RotateByCycle.new
  # end
end
