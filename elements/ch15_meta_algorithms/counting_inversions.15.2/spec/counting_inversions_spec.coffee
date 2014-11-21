mod = require '../count_inversions'

arr = [1,2,3,4,3,2,1]
inv = 9

count_behave_right = (count)->
  it "should count number of inversions", ->
    expect(count(arr)).toEqual inv

describe 'naive_count', ->
  count = mod.naive_count
  count_behave_right(count)

describe 'count_by_merge', ->
  count = mod.count_by_merge
  count_behave_right(count)
