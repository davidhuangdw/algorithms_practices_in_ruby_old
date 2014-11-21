
def zero_subset(arr)
    last_index,pre_sum = [],[]
    arr.each_with_index do |v,i|
        pre_sum[i] = v+(i==0 ? 0:pre_sum[i-1])
        hash = pre_sum[i]%arr.size
        return [last_index[hash]+1, i] unless last_index[hash].nil?
        last_index[hash] = i
    end
    [nil,nil]
end
