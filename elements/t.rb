#!/usr/bin/env ruby

@deps = Hash.new []

def add(name, dep=[])
    @deps[name] = dep
end

def run_task(name)
    @invoked = {}
    invoke name
end

def invoke(name)
    return if @invoked[name]
    @invoked[name] = true
    @deps[name].each {|t| invoke t}

    #invoking by print
    puts name
end


add "cook", ["having food", "boiling water"]
add "boiling water", ["having food"]
add "boiling water", ["get water", "boil 10 min"]
add "boil 10 min", ["get water"]
add "having food", ["shopping"]
add "shopping", ["driving", "get money"]
add "driving", ["get money"]

run_task "cook"
