

class SquareArray
  attr_reader :array
  def initialize(array)
    @array = array
    raise ArgumentError unless square?
  end

  def size
    array.size
  end

  def rotate!
    n_layer=row_count/2
    (0..n_layer-1).each { |dep| rotate_border!(dep) }
    self
  end

  def [](i)
    array[i]
  end

private
  def row_count
    array.size
  end
  def rotate_border!(dep)
    (dep..mirror(dep)-1).each do |j|
      i = dep
      3.times do
        si,sj = source_index(i, j)
        self[i][j],self[si][sj] = self[si][sj],self[i][j]
        i,j= si,sj
      end
    end
  end

  def mirror(i)
    size-1-i
  end

  def source_index(i,j)
    [mirror(j),i]
  end

  def square?
    array.each do |sub|
      return false unless sub.size == size
    end
    true
  end
end