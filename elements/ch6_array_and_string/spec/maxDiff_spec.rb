require_relative '../maxDiff.rb'

describe MaxDiff do
    describe "return max sum of k diffs" do
        it "return k for [0,1,0,1,0...]" do
            arr = [0,1]*100
            df = MaxDiff.new(arr)
            (1..20).each do |k|
                expect(df.sum(k)).to eq(k)
            end
        end
        it "return 2*k for [0,2,0,2,0...]" do
            arr = [0,2]*100
            df = MaxDiff.new(arr)
            (1..20).each do |k|
                expect(df.sum(k)).to eq(k*2)
            end
        end
    end
end

