
def evaluate(arr)
    stack=[]
    arr.each do |x|
        if x =~ /\d+/
            stack << Float(x)
        else
            b=stack.pop
            a=stack.pop
            stack << (eval "#{a} #{x} #{b}")
        end
    end
    stack.last
end


puts evaluate(%w{4 6 / 2 /})
puts evaluate(%w{3 4 * 1 2 + +})
puts evaluate(%w{1 1 + -2 *})

