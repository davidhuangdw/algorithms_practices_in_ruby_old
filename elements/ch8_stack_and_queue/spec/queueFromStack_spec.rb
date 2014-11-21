require_relative '../queueFromStack'
require_relative '../queue'

describe QueueFromStack do
    before(:all) do 
        @que=QueueFromStack.new
        @simple = MyQueue.new
    end

    let (:push) do
        (1..4).each do |x|
            @que.push(x)
            @simple.push(x)
        end
    end

    let (:pop) do
        [@que.pop, @simple.pop]
    end

    describe "#push" do
        it "push to tail" do
            push
            expect(@que.keys).to eq(@simple.keys)
        end
    end

    describe "#pop" do
        it "pop from head" do
            x,y = pop
            expect(x).to eq(y)
            expect(@que.keys).to eq(@simple.keys)
            expect(@que.keys).to eq([4,3,2])
        end

        it "still normal after some put and some pop" do
            expect(@que.keys).to eq([4,3,2])
            push;pop;pop;push;pop;pop;pop
            expect(@que.keys).to eq(@simple.keys)
        end
    end

end
