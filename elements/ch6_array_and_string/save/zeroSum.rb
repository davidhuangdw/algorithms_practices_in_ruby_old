

def zero_subset(arr)
    last,pre = [],[]
    arr.each_with_index do |k,i|
        pre[i] = k+(i==0 ? 0:pre[i-1])
        pos = pre[i]%arr.size
        return [last[pos]+1, i] unless last[pos].nil?
        last[pos] = i
    end

    [nil,nil]
end
