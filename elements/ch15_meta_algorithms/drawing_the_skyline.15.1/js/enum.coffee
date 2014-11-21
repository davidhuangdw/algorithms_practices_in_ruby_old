StopIteration =
  name:"stop iteration"

puts = console.log
lp = (f) ->
  try
    f() while true
  catch StopIteration

prototype =
  check: -> throw StopIteration if @i>=@array.length
  peek: ->
    @check()
    @array[@i]
  next: ->
    result = @peek()
    @i++
    result

Enum = (array,i=0) ->
  eunm = Object.create(prototype)
  eunm.array=array
  eunm.i = i
  eunm

module.exports =
  loop: lp
  Enum: Enum