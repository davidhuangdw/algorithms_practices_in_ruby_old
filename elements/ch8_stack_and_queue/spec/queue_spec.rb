
require_relative '../queue'

describe Queue do
    before do
        @que = MyQueue.new
    end

    describe "#push" do
        it "push a key to tail" do
            @que.push(1)
            @que.push(2)
            @que.push(3)
            expect(@que.keys).to eq([3,2,1])
        end
    end

    describe "#pop" do
        it "pop element from head" do
            @que.push(1)
            @que.push(2)
            @que.push(3) #[3,2,1]
            expect(@que.pop).to eq(1)
            expect(@que.keys).to eq([3,2])
        end
    end
end
