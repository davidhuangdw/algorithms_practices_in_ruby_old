require_relative '../queueWithMax'

class MyQueue
    def max
        @keys.max
    end
end

describe QueueWithMax do
    before(:all) do 
        @que=QueueWithMax.new
        @normal = MyQueue.new
    end

    describe "#push" do
        it "push to tail" do
            (1..4).each do |x|
                @que.push(x)
                @normal.push(x)
            end

            expect(@que.keys).to eq(@normal.keys)
            expect(@que.keys).to eq([4,3,2,1])
        end
    end

    describe "#pop" do
        it "pop from head" do
            x,y = @que.pop,@normal.pop
            expect(x).to eq(1)
            expect(@que.keys).to eq([4,3,2])
            expect(@que.keys).to eq(@normal.keys)
        end
    end

    def push(x)
        @que.push(x)
        @normal.push(x)
    end
    let (:pop) do
        @que.pop
        @normal.pop
    end

    describe "#max" do
        it "keep max while pushing, or poping" do
            @que = QueueWithMax.new
            @normal = MyQueue.new
            push(1)
            expect(@que.max).to eq(1)

            push(2)
            expect(@que.max).to eq(2)

            pop
            expect(@que.max).to eq(2)

            [4,19,37,36,18,5,2,10].each do |x|
                push(x)
                expect(@que.max).to eq(@normal.max)
            end

            7.times do
                pop
                expect(@que.max).to eq(@normal.max)
            end
        end
    end
end
