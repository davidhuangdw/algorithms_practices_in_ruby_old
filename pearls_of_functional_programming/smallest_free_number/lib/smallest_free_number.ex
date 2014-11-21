defmodule SmallestFreeNumber do
    def smallest_free(array, from\\1)

    def smallest_free([], from), do: from
    def smallest_free(array, from) do
        array = Enum.filter(array, &(&1>0))
        low_half_size = div((length(array)+1),2)
        low_max = from + low_half_size - 1
        {low,high} = Enum.partition(array, &(&1<=low_max))
        if contain_free?(length(low), low_half_size),
            do: smallest_free(low, from),
            else: smallest_free(high, low_max+1)
    end

    def contain_free?(actual_size, value_range_size) do
        actual_size != value_range_size
    end
    
end
