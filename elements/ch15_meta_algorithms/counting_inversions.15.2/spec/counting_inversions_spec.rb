require_relative '../couting_inversions'

describe InversionsCount do
  let(:array) { [1,2,3,4,3,2,1]}
  let(:inversion_count) { 9 }
  subject {InversionsCount.new(array)}
  it "should count number of inversion pairs" do
    expect(subject.count).to eq inversion_count
  end
end