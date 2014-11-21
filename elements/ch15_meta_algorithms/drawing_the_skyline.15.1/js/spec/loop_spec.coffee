Enum = require '../enum'

describe "External Enumerator", ->
  arr = [1,2,3]
  it "should be able to iterate an array", ->
    result = []
    e = Enum.Enum(arr)
    Enum.loop ->
      result.push(e.next())
    expect(result).toEqual arr

  it "should be able to peek, without forward", ->
    e = Enum.Enum(arr)
    e.next()
    expect(e.peek()).toEqual 2
    expect(e.peek()).toEqual 2
