require_relative '../lazy'

describe LazyArray do
    before(:all) {@a=LazyArray.new}
    it "read same value after write" do
        expect(@a.size).to eq(0)
        @a[5] = 10
        expect(@a[5]).to eq(10)
    end
    it "return false when reading an unwritten value" do
        expect(@a[5]).not_to eq(false)
        expect(@a[3]).to eq(false)
        expect(@a[0]).to eq(false)
    end
    it "behavior normal even write same element many times" do
        @a[5] = 1
        @a[5] = 2
        expect(@a[5]).to eq(2)
        expect(@a.size).to eq(1)
    end
end
