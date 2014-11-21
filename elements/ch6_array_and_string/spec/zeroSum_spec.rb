require_relative '../zeroSum'

describe "#zero_sunbset" do
    it "return subset whose'sum is 0 mod n" do
        [[1,10],[200,300], [220,258]].each do |a,b|
            arr = (a..b).to_a
            l,r = zero_subset(arr)
            expect(l).not_to eq(nil)
            expect(arr[l..r].inject(:+)%arr.size).to eq(0)
        end
    end
end
