# Quick Implementation Guide: Reproduce Unweighted Paper Gadgets

## ✅ What's Already Done

I've created a **minimal working implementation** with 3 gadgets:

1. ✅ **Core infrastructure** (`src/core.jl`, `src/utils.jl`)
2. ✅ **3 gadgets implemented**:
   - `Cross{true}` - Connected crossing
   - `Cross{false}` - Large crossing  
   - `Turn` - 90° turn
   - `TrivialTurn` - Minimal turn
3. ✅ **Basic tests passing**

## 🚀 How to Add More Gadgets (Fast Method)

### Method 1: Copy from UnitDiskMapping.jl (Recommended)

1. **Open** `F:\AI-project\UnitDiskMapping.jl\src\gadgets.jl`
2. **Find** the gadget you want (e.g., `WTurn`, `Branch`, etc.)
3. **Copy** the struct definition and both `source_graph()` and `mapped_graph()` functions
4. **Paste** into `F:\AI-project\UnweightedGadgetSearch.jl\src\gadgets.jl`
5. **Add** to exports at the bottom of `gadgets.jl`
6. **Test** by running `julia --project=. test/test_gadgets.jl`

### Example: Adding WTurn

```julia
# In src/gadgets.jl, add:

struct WTurn <: Gadget end

# ⋅ ⋅ ⋅ ⋅
# ⋅ ⋅ ● ●
# ⋅ ● ● ⋅
# ⋅ ● ⋅ ⋅
function source_graph(::WTurn)
    locs = [Node(2,3), Node(2,4), Node(3,2), Node(3,3), Node(4,2)]
    g = simplegraph([(1,2), (1,4), (3,4), (3,5)])
    return locs, g, [2, 5]
end

# ⋅ ⋅ ⋅ ⋅
# ⋅ ⋅ ⋅ ●
# ⋅ ⋅ ● ⋅
# ⋅ ● ⋅ ⋅
function mapped_graph(::WTurn)
    locs = [Node(2,4), Node(3,3), Node(4,2)]
    return locs, unitdisk_graph(locs, 1.5), [1, 3]
end

# Add to exports:
export WTurn
```

## 📋 Complete List of Gadgets to Add

From `UnitDiskMapping.jl`, you need to add:

1. ✅ `Cross{true}` - Done
2. ✅ `Cross{false}` - Done
3. ✅ `Turn` - Done
4. ⬜ `WTurn` - Copy from UnitDiskMapping.jl line 215-235
5. ⬜ `Branch` - Copy from UnitDiskMapping.jl line 169-190
6. ⬜ `BranchFix` - Copy from UnitDiskMapping.jl line 193-213
7. ⬜ `TCon` - Copy from UnitDiskMapping.jl line 260-280
8. ✅ `TrivialTurn` - Done
9. ⬜ `BranchFixB` - Copy from UnitDiskMapping.jl line 237-257
10. ⬜ `EndTurn` - Copy from UnitDiskMapping.jl line 301-319

## 🎯 Quick Workflow

For each gadget:

1. **Copy** struct + source_graph + mapped_graph from UnitDiskMapping.jl
2. **Paste** into your gadgets.jl
3. **Add** to exports
4. **Test**: `julia --project=. -e "using UnweightedGadgetSearch; source_graph(WTurn())"`
5. **Commit** when working

## ⚡ Fastest Path (30 minutes)

1. Open both files side-by-side:
   - `UnitDiskMapping.jl/src/gadgets.jl` (source)
   - `UnweightedGadgetSearch.jl/src/gadgets.jl` (target)

2. Copy-paste all remaining gadgets (WTurn, Branch, BranchFix, TCon, BranchFixB, EndTurn)

3. Run test: `julia --project=. test/test_gadgets.jl`

4. Fix any errors (usually just import/export issues)

5. Done! ✅

## 📝 Testing

```julia
# Quick test in Julia REPL:
using UnweightedGadgetSearch

# Test each gadget
for gadget in [Cross{true}(), Cross{false}(), Turn(), TrivialTurn()]
    locs1, g1, pins1 = source_graph(gadget)
    locs2, g2, pins2 = mapped_graph(gadget)
    println("✓ $(typeof(gadget)): $(nv(g1))→$(nv(g2)) vertices")
end
```

## 🎓 Understanding the Structure

Each gadget needs:
- **Struct**: `struct GadgetName <: Gadget end`
- **source_graph()**: Returns `(locs, graph, pins)` for original pattern
- **mapped_graph()**: Returns `(locs, graph, pins)` for replacement

That's it! The rest is just copying from the working implementation.

