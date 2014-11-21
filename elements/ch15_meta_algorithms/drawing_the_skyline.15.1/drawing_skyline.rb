require_relative 'scan_strategy'


Segment = Struct.new(:left,:right,:height) do
  def to_ary
    [left,right,height]
  end

  def <=>(other)
    to_ary <=> other.to_ary
  end
end

class DrawingSkyline
  attr_reader :buildings, :skyline_compute_strategy
  def initialize(buildings, compute_strategy)
    @buildings = buildings.to_ary
    @skyline_compute_strategy = compute_strategy.new(self)
  end
  def skylines
    @skylines ||= skyline_compute_strategy.compute
  end

  def to_ary
    skylines.map {|seg| seg.to_ary}
  end

  def create_segment(*args)
    Segment.new(*args)
  end

  def building_segments
    buildings.map{|b| create_segment(*b)}
  end

  def join_adjacent(segments)
    return segments if segments.empty?
    result,last = [],segments.first
    segments[1..-1].each do |seg|
      if joinable?(last, seg)
        last.right = seg.right
      else
        result << last
        last = seg
      end
    end
    result << last
  end

  def joinable?(left, right)
    left.right >= right.left &&
        left.height == right.height
  end
end

