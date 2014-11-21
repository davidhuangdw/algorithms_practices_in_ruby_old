class PrimeGenerator
  attr_reader :bound, :primes
  def initialize(bound)
    @bound = bound
    @primes= []
    @min_factor_index_of = []
    generate_primes
  end

  def prime?(v)
    assert_in_range(v)
    min_factor_of(v) == v
  end

  def factors(v)
    assert_in_range(v)
    safe_factors(v)
  end

private
  attr_accessor :min_factor_index_of
  attr_writer :primes
  def generate_primes
    (2..bound).each do |v|
      if min_factor_index_of[v].nil?
        self.primes<<v
        min_factor_index_of[v] = primes.size-1
      end
      mark_compound_of(v)
    end
  end

  def mark_compound_of(v)
    # every compound are marked only once by: compound/its_min_factor === v
    (0..min_factor_index_of[v]).each do |i|
      compound = @primes[i]*v
      break if compound>bound
      min_factor_index_of[compound] = i
    end
  end

  def safe_factors(v)
    factors = []
    until v==1
      factor = min_factor_of(v)
      factors << factor
      v /= factor
    end
    factors
  end

  def min_factor_of(v)
    primes[min_factor_index_of[v]]
  end

  def assert_in_range(v)
    raise ArgumentError,
          "query #{v} out of bound range [1..#{bound}]" unless (1..bound).include?(v)
  end
end