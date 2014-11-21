require_relative '../century'
require_relative '../bounded_century'

shared_examples_for "century" do
  let(:size) {9}
  let(:value) {100}
  it "should collect all expression that eq a value" do
    expect(subject.all.size).to eq 7
  end
end
describe Century do
  subject {Century.new(size,value)}
  it_should_behave_like "century"
end
describe BoundedCentury do
  subject {BoundedCentury.new(size,value)}
  it_should_behave_like "century"
end
