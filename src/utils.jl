# Utility functions for gadget implementation

using Graphs

"""
Create a simple graph from an edge list.
"""
function simplegraph(edgelist::AbstractVector{Tuple{Int,Int}})
    nv = maximum(x->max(x...), edgelist; init=0)
    nv == 0 && return SimpleGraph(0)
    g = SimpleGraph(nv)
    for (i,j) in edgelist
        add_edge!(g, i, j)
    end
    return g
end

"""
Create a unit disk graph from locations.
Two vertices are connected if distance < unit.
"""
function unitdisk_graph(locs::AbstractVector, unit::Real)
    n = length(locs)
    g = SimpleGraph(n)
    for i=1:n, j=i+1:n
        if sum(abs2, locs[i].loc .- locs[j].loc) < unit^2
            add_edge!(g, i, j)
        end
    end
    return g
end

