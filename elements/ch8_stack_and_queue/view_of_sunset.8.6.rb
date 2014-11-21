
class View
    attr_reader :buildings
    def initialize
        @buildings = []
    end

    def add(h)
        @buildings.pop until @buildings.empty? || @buildings.last > h
        @buildings << h
    end
end

require_relative 'basic'

v = View.new
arr = gen
p arr
arr.each {|h|
    v.add(h)
    p v.buildings
}
