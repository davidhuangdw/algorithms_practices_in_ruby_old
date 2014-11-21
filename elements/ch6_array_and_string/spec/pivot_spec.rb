require_relative '../pivot'

describe "#pivot!" do
    it "partition array into three parts: <, =, >" do
        arr=[1,3,3,2,1,1,1,2,2]
        arr.pivot!(arr[3])
        expect(arr).to eq([1,1,1,1,2,2,2,3,3])
    end
end
