require_relative '../prime'

describe PrimeGenerator do
  let(:bound) {100}
  let(:primes) {[2, 3, 5, 7, 11, 13, 17, 19, 23,
                 29, 31, 37, 41, 43, 47, 53, 59,
                 61, 67, 71, 73, 79, 83, 89, 97]}
  subject {PrimeGenerator.new(bound)}
  describe "#primes" do
    it "should generate all primes" do
      expect(subject.primes).to eq primes
    end
  end

  describe "#prime?" do
    let(:some_prime) {29}
    let(:some_compound) {27}
    it "should tell a value be a prime or not" do
      expect(subject.prime?(some_prime)).to eq true
      expect(subject.prime?(some_compound)).to eq false
    end
  end

  describe "#factors" do
    let(:value) {60}
    let(:factors) {[2,2,3,5]}
    it "should generate all factors for a value" do
      expect(subject.factors(value)).to eq factors
    end
  end
end