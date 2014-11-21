defmodule SmallestFreeNumberTest do
  use ExUnit.Case
  import SmallestFreeNumber

  test "smallest_free" do
    assert smallest_free([]) == 1
    assert smallest_free([4,8,3,1,2]) == 5
    assert smallest_free([4,5,3,10,1,2]) == 6
  end
end
