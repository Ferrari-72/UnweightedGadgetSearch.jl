module UnweightedGadgetSearch

# Include all gadget definitions
include("core.jl")
include("utils.jl")
include("gadgets.jl")

# Re-export everything
export Cross, Turn, TrivialTurn
export source_graph, mapped_graph
export Node, simplegraph, unitdisk_graph

greet() = println("Hello from UnweightedGadgetSearch!")

end # module
