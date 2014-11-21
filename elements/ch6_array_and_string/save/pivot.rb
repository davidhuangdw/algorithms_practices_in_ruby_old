

class Array
    def swap(i,j)
        self[i],self[j] = self[j],self[i]
    end

    def pivot!(key)
        eq,gt = 0,size
        each_with_index do |v,i|
            break if i>=gt
            next if v==key

            if v<key
                swap(eq,i)
                eq+=1
            else
                swap(i,gt-1)
                gt-=1
            end
        end
    end
end
