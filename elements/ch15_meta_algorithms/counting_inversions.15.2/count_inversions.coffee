puts = console.log

naive_count = (arr) ->
  result = 0
  n = arr.length
  for i in [0...n]
    for j in [i+1...n]
      result++ if arr[i] > arr[j]
  result

count_by_merge = (arr) ->
  return 0 if arr.length <= 1
  [l,r] = divide(arr)
  count_by_merge(l) +
    count_by_merge(r) +
    count_and_merge(arr, l, r)

count_and_merge = (->
  count = i = il = ir = undefined

  init = -> count = i = il = ir = 0

  keep_pick_smallest = (arr,l,r)->
    until il>=l.length or ir>=r.length
      [fl,fr] = [l[il], r[ir]]
      if fl <= fr
        count += ir
        arr[i++] = l[il++]
      else
        arr[i++] = r[ir++]

  exhaust_remain = (arr,l,r) ->
    until il >= l.length
      count += ir
      arr[i++] = l[il++]
    until ir >= r.length
      arr[i++] = r[ir++]

  (arr, l, r) ->
    init()
    keep_pick_smallest(arr,l,r)
    exhaust_remain(arr,l,r)
    count
)()

divide = (arr) ->
  half = Math.ceil (arr.length/2)
  [arr[0...half], arr[half..-1]]

module.exports = {
  naive_count: naive_count
  count_by_merge: count_by_merge
}
