app = require "../drawing_skyline"
by_enum = require "../merge_by_enum"


correctly_draw_example = (draw, buildings, lines) ->
  it "should compute the skyline of buildings", ->
    expect(draw(buildings)).toEqual lines

correctly_draw = (draw) ->
  describe "for contiguous examples", ->
    buildings = [ [0,3,1],
                  [1,6,3],
                  [4,8,4],
                  [5,9,2],
                  [7,14,3],
                  [10,12,6],
                  [11,17,1],
                  [13,16,2]
    ]
    lines = [ [0,1,1],
              [1,4,3],
              [4,8,4],
              [8,10,3],
              [10,12,6],
              [12,14,3],
              [14,16,2],
              [16,17,1]
    ]
    correctly_draw_example(draw,buildings,lines)

  describe "for non-contiguous examples", ->
    buildings =     [ [0,3,1],
                      [1,6,3],
                      [4,8,4],
                      [5,9,2],
                      [10,12,6],
                      [11,17,1],
                      [13,16,2]
                    ]
    lines =    [[0,1,1],
                [1,4,3],
                [4,8,4],
                [8,9,2],
                [10,12,6],
                [12,13,1],
                [13,16,2],
                [16,17,1]
                ]
    correctly_draw_example(draw,buildings,lines)

describe 'skylines', ->
  describe 'draw_by_merge', ->
    correctly_draw(app.draw_by_merge)
  describe 'draw_by_merge, with merge_by_enum', ->
    correctly_draw(by_enum.draw_by_merge)

