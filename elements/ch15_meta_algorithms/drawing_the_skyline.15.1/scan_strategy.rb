require_relative 'drawing_skyline'

Border = Struct.new(:x, :height, :direction) do
  def up?
    direction == :up
  end
  def to_ary
    [x, height]
  end
end

class SkylineComputeByScan < SimpleDelegator
  def compute
    @skylines,@max_h,@remain = [],-1,Hash.new(0)
    borders.each do |border|
      border.up? ? insert(border) : remove(border)
    end
    join_adjacent skylines
  end

private
  attr_accessor :skylines,:remain, :left,:max_h

  def insert(border)
    x,h = border
    remain[h] += 1
    if new_highest?(h)
      end_last_at(x)
      begin_at(x,h)
    end
  end

  def remove(border)
    x,h = border
    remain[h] -= 1
    if drop_at?(h)
      end_last_at(x)
      begin_at(x,max)
    end
  end

  def max
    remain.select{|k,v| v>0}.keys.max
  end

  def new_highest?(h)
    h > max_h
  end

  def drop_at?(h)
    h == max_h && remain[h] == 0
  end

  def end_last_at(x)
    if left
      skylines << create_segment(left,x,max_h)
      @left,@max_h = nil,-1
    end
  end

  def begin_at(x,h)
    @left,@max_h = x,h if h
  end

  def borders
    @borders ||=
        buildings.flat_map do |left, right, height|
          [create_border(left,height,:up),
           create_border(right,height,:down)]
        end.
            sort_by{|b| [b.x, b.height, b.up? ? 1:0]}
  end

  def create_border(*args)
    Border.new(*args)
  end
end
