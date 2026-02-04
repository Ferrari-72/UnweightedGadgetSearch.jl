# Unweighted gadget definitions from the paper
# Reproduced based on ASCII patterns in the code (which represent paper descriptions)

include("core.jl")
include("utils.jl")

"""
Abstract type for all gadgets.
Each gadget must implement:
- source_graph() -> (locs, graph, pins)
- mapped_graph() -> (locs, graph, pins)
"""
abstract type Gadget end

# ============================================================================
# Cross Gadgets
# ============================================================================

struct Cross{CON} <: Gadget end

# Cross{true}: Connected crossing (3×3 pattern)
# Source pattern:
# ⋅ ● ⋅
# ◆ ◉ ●
# ⋅ ◆ ⋅
# (● = vertex, ◆ = connected vertex, ◉ = crossing point)
function source_graph(::Cross{true})
    locs = [Node(2,1), Node(2,2), Node(2,3), Node(1,2), Node(2,2), Node(3,2)]
    g = simplegraph([(1,2), (2,3), (4,5), (5,6), (1,6)])
    return locs, g, [1,4,6,3]
end

# Mapped pattern:
# ⋅ ● ⋅
# ● ● ●
# ⋅ ● ⋅
function mapped_graph(::Cross{true})
    locs = [Node(2,1), Node(2,2), Node(2,3), Node(1,2), Node(3,2)]
    return locs, unitdisk_graph(locs, 1.5), [1,4,5,3]
end

# Cross{false}: Large crossing (4×5 pattern)
# Source pattern:
# ⋅ ⋅ ● ⋅ ⋅
# ● ● ◉ ● ●
# ⋅ ⋅ ● ⋅ ⋅
# ⋅ ⋅ ● ⋅ ⋅
function source_graph(::Cross{false})
    locs = [Node(2,1), Node(2,2), Node(2,3), Node(2,4), Node(2,5), 
            Node(1,3), Node(2,3), Node(3,3), Node(4,3)]
    g = simplegraph([(1,2), (2,3), (3,4), (4,5), (6,7), (7,8), (8,9)])
    return locs, g, [1,6,9,5]
end

# Mapped pattern:
# ⋅ ⋅ ● ⋅ ⋅
# ● ● ● ● ●
# ⋅ ● ● ● ⋅
# ⋅ ⋅ ● ⋅ ⋅
function mapped_graph(::Cross{false})
    locs = [Node(2,1), Node(2,2), Node(2,3), Node(2,4), Node(2,5), 
            Node(1,3), Node(3,3), Node(4,3), Node(3,2), Node(3,4)]
    return locs, unitdisk_graph(locs, 1.5), [1,6,8,5]
end

# ============================================================================
# Turn Gadget
# ============================================================================

struct Turn <: Gadget end

# Source pattern:
# ⋅ ● ⋅ ⋅
# ⋅ ● ⋅ ⋅
# ⋅ ● ● ●
# ⋅ ⋅ ⋅ ⋅
function source_graph(::Turn)
    locs = [Node(1,2), Node(2,2), Node(3,2), Node(3,3), Node(3,4)]
    g = simplegraph([(1,2), (2,3), (3,4), (4,5)])
    return locs, g, [1,5]
end

# Mapped pattern:
# ⋅ ● ⋅ ⋅
# ⋅ ⋅ ● ⋅
# ⋅ ⋅ ⋅ ●
# ⋅ ⋅ ⋅ ⋅
function mapped_graph(::Turn)
    locs = [Node(1,2), Node(2,3), Node(3,4)]
    return locs, unitdisk_graph(locs, 1.5), [1,3]
end

# ============================================================================
# WTurn: Wide Turn
# ============================================================================

struct WTurn <: Gadget end

# Source pattern:
# ⋅ ⋅ ⋅ ⋅
# ⋅ ⋅ ● ●
# ⋅ ● ● ⋅
# ⋅ ● ⋅ ⋅
function source_graph(::WTurn)
    locs = [Node(2,3), Node(2,4), Node(3,2), Node(3,3), Node(4,2)]
    g = simplegraph([(1,2), (1,4), (3,4), (3,5)])
    return locs, g, [2, 5]
end

# Mapped pattern:
# ⋅ ⋅ ⋅ ⋅
# ⋅ ⋅ ⋅ ●
# ⋅ ⋅ ● ⋅
# ⋅ ● ⋅ ⋅
function mapped_graph(::WTurn)
    locs = [Node(2,4), Node(3,3), Node(4,2)]
    return locs, unitdisk_graph(locs, 1.5), [1, 3]
end

# ============================================================================
# Branch: T-junction with branch
# ============================================================================

struct Branch <: Gadget end

# Source pattern:
# ⋅ ● ⋅ ⋅
# ⋅ ● ⋅ ⋅
# ⋅ ● ● ●
# ⋅ ● ● ⋅
# ⋅ ● ⋅ ⋅
function source_graph(::Branch)
    locs = [Node(1,2), Node(2,2), Node(3,2), Node(3,3), Node(3,4), Node(4,3), Node(4,2), Node(5,2)]
    g = simplegraph([(1,2), (2,3), (3, 4), (4,5), (4,6), (6,7), (7,8)])
    return locs, g, [1, 5, 8]
end

# Mapped pattern:
# ⋅ ● ⋅ ⋅
# ⋅ ⋅ ● ⋅
# ⋅ ● ⋅ ●
# ⋅ ⋅ ● ⋅
# ⋅ ● ⋅ ⋅
function mapped_graph(::Branch)
    locs = [Node(1,2), Node(2,3), Node(3,2), Node(3,4), Node(4,3), Node(5,2)]
    return locs, unitdisk_graph(locs, 1.5), [1,4,6]
end

# ============================================================================
# BranchFix: T-junction simplification
# ============================================================================

struct BranchFix <: Gadget end

# Source pattern:
# ⋅ ● ⋅ ⋅
# ⋅ ● ● ⋅
# ⋅ ● ● ⋅
# ⋅ ● ⋅ ⋅
function source_graph(::BranchFix)
    locs = [Node(1,2), Node(2,2), Node(2,3), Node(3,3), Node(3,2), Node(4,2)]
    g = simplegraph([(1,2), (2,3), (3,4), (4,5), (5,6)])
    return locs, g, [1, 6]
end

# Mapped pattern:
# ⋅ ● ⋅ ⋅
# ⋅ ● ⋅ ⋅
# ⋅ ● ⋅ ⋅
# ⋅ ● ⋅ ⋅
function mapped_graph(::BranchFix)
    locs = [Node(1,2), Node(2,2), Node(3,2), Node(4,2)]
    return locs, unitdisk_graph(locs, 1.5), [1, 4]
end

# ============================================================================
# BranchFixB: Alternate branch fix
# ============================================================================

struct BranchFixB <: Gadget end

# Source pattern:
# ⋅ ⋅ ⋅ ⋅
# ⋅ ⋅ ● ⋅
# ⋅ ● ● ⋅
# ⋅ ● ⋅ ⋅
function source_graph(::BranchFixB)
    locs = [Node(2,3), Node(3,2), Node(3,3), Node(4,2)]
    g = simplegraph([(1,3), (2,3), (2,4)])
    return locs, g, [1, 4]
end

# Mapped pattern:
# ⋅ ⋅ ⋅ ⋅
# ⋅ ⋅ ⋅ ⋅
# ⋅ ● ⋅ ⋅
# ⋅ ● ⋅ ⋅
function mapped_graph(::BranchFixB)
    locs = [Node(3,2), Node(4,2)]
    return locs, unitdisk_graph(locs, 1.5), [1, 2]
end

# ============================================================================
# TCon: T-shape with connected vertices
# ============================================================================

struct TCon <: Gadget end

# Source pattern:
# ⋅ ◆ ⋅ ⋅
# ◆ ● ⋅ ⋅
# ⋅ ● ⋅ ⋅
# (◆ = connected vertex)
function source_graph(::TCon)
    locs = [Node(1,2), Node(2,1), Node(2,2), Node(3,2)]
    g = simplegraph([(1,2), (1,3), (3,4)])
    return locs, g, [1,2,4]
end

# Mapped pattern:
# ⋅ ● ⋅ ⋅
# ● ⋅ ● ⋅
# ⋅ ● ⋅ ⋅
function mapped_graph(::TCon)
    locs = [Node(1,2), Node(2,1), Node(2,3), Node(3,2)]
    return locs, unitdisk_graph(locs, 1.5), [1,2,4]
end

# ============================================================================
# TrivialTurn: Minimal turn (2×2)
# ============================================================================

struct TrivialTurn <: Gadget end

# Source pattern:
# ⋅ ◆
# ◆ ⋅
function source_graph(::TrivialTurn)
    locs = [Node(1,2), Node(2,1)]
    g = simplegraph([(1,2)])
    return locs, g, [1,2]
end

# Mapped pattern:
# ⋅ ●
# ● ⋅
function mapped_graph(::TrivialTurn)
    locs = [Node(1,2), Node(2,1)]
    return locs, unitdisk_graph(locs, 1.5), [1,2]
end

# ============================================================================
# EndTurn: Terminal turn
# ============================================================================

struct EndTurn <: Gadget end

# Source pattern:
# ⋅ ● ⋅ ⋅
# ⋅ ● ● ⋅
# ⋅ ⋅ ⋅ ⋅
function source_graph(::EndTurn)
    locs = [Node(1,2), Node(2,2), Node(2,3)]
    g = simplegraph([(1,2), (2,3)])
    return locs, g, [1]
end

# Mapped pattern:
# ⋅ ● ⋅ ⋅
# ⋅ ⋅ ⋅ ⋅
# ⋅ ⋅ ⋅ ⋅
function mapped_graph(::EndTurn)
    locs = [Node(1,2)]
    return locs, unitdisk_graph(locs, 1.5), [1]
end

# Export all gadgets
export Cross, Turn, WTurn, Branch, BranchFix, BranchFixB, TCon, TrivialTurn, EndTurn
export source_graph, mapped_graph
