require_relative '../bigInteger.rb'

describe "method to_digits" do
    it "conver string to digits" do
        expect(to_digits("123")).to eq([3,2,1])
        expect(to_digits("00123")).to eq([3,2,1])
        expect(to_digits("0000")).to eq([0])
        expect(to_digits("0")).to eq([0])
    end
end

describe MyInteger do
    describe "#to_s" do
        it "represent integer as string" do
            a = MyInteger.new("1230")
            expect(a.to_s).to eq("1230")
        end
    end
    context "when #add" do
        it "add bigInteger correctly" do
            sa,sb = "1234567890","9876543210"
            a,b = MyInteger.new(sa), MyInteger.new(sb)
            expect((a+b).to_s).to  \
                eq((Integer(sa)+Integer(sb)).to_s)
        end
    end

    context "when #multiply" do
        it "multiply bigInteger correctly" do
            [["2","3"],["66","88"],["1234567890","9876543210"]].each \
                do |sa, sb|
                a,b = MyInteger.new(sa), MyInteger.new(sb)
                expect((a*b).to_s).to  \
                    eq((Integer(sa)*Integer(sb)).to_s)
            end
        end
    end
end
