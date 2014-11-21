class Combinations
  def initialize(size)
    @size = size
  end

  def each(&blk)
    each_of(@size,&blk)
  end
  include Enumerable
private
  def each_of(i,&blk)
    return yld(i.to_s,&blk) if i == 1

    each_of(i-1) do |pre|
      ['', '+', '*'].each do |op|
        yld(pre+op+i.to_s, &blk)
      end
    end
  end

  def yld(value)
    yield value
  end
end

class Expression
  attr_reader :expr
  def initialize(expr)
    @expr = String(expr)
  end

  def value
    @value ||= compute
  end

private
  def compute
    @expr.split('+').
        map(&method(:compute_factor)).
        reduce(0,:+)
  end
  def compute_factor(factor)
    factor.split('*').
        map(&:to_i).reduce(1,:*)
  end
end

class Century
  attr_reader :size, :value
  def initialize(size,value)
    @size = size
    @value = value
  end
  def all
    combinations.select do |expr|
      expression(expr).value == value
    end.sort
  end
private
  def combinations
    Combinations.new(@size)
  end
  def expression(expr)
    Expression.new(expr)
  end
end
