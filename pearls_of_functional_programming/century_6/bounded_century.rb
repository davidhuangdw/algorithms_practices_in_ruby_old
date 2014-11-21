require_relative 'century'
class BoundedCombinations < Combinations
  def initialize(size, bound)
    @bound = bound
    super(size)
  end
private
  def yld(exp)
    yield exp if expression(exp).value <= @bound
  end
  def expression(exp)
    Expression.new(exp)
  end
end

class BoundedCentury < Century
private
  def combinations
    BoundedCombinations.new(@size,@value)
  end
end