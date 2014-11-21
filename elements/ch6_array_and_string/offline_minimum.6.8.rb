
class OfflineExtract
  def initialize(permutation, exacts)
    @perm = permutation
    @exacts = exacts.map {|i|@perm[i] }
  end

  def mins
    result = [(@perm-@exacts).min].compact
    @exacts.reverse_each do |x|
      result.unshift [result.last, x].min
    end
    result
  end
end