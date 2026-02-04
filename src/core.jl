# Core types and utilities for unweighted gadgets

using Graphs

# Simple Node type for unweighted graphs
struct Node
    loc::Tuple{Int,Int}
    Node(x::Int, y::Int) = new((x, y))
    Node(loc::Tuple{Int,Int}) = new(loc)
end

# Accessors
Base.getindex(n::Node, i::Int) = n.loc[i]
getxy(n::Node) = n.loc

