# Quick Start: Reproduce Unweighted Paper Gadgets

## Strategy: Copy and Adapt from UnitDiskMapping.jl

The fastest way to implement the gadgets is to:
1. Copy the gadget definitions from `UnitDiskMapping.jl`
2. Copy necessary utility functions
3. Create a minimal test to verify

## Step 1: Copy Core Utilities

Copy these files/functions from `UnitDiskMapping.jl`:
- `src/utils.jl` - `simplegraph()`, `unitdisk_graph()`
- `src/Core.jl` - `Node` type definition
- Basic graph operations

## Step 2: Copy Gadget Definitions

Copy gadget structs and functions from `UnitDiskMapping.jl/src/gadgets.jl`:
- `Cross{true}` and `Cross{false}`
- `Turn`
- `WTurn`
- `Branch`
- `BranchFix`
- `TCon`
- `TrivialTurn`
- `BranchFixB`
- `EndTurn`

## Step 3: Create Minimal Test

Create a simple test file that:
- Imports necessary dependencies
- Tests one gadget first (e.g., `Cross{true}`)
- Verifies it works

## Implementation Order

1. **Start with one simple gadget** (e.g., `Turn` or `TrivialTurn`)
2. **Get it working** with minimal dependencies
3. **Add more gadgets** one by one
4. **Test each** before moving to the next

## Files to Create

```
UnweightedGadgetSearch.jl/
├── src/
│   ├── UnweightedGadgetSearch.jl  (main module)
│   ├── gadgets.jl                  (gadget definitions)
│   ├── utils.jl                    (utility functions)
│   └── core.jl                     (Node type, basic types)
└── test/
    └── test_gadgets.jl             (simple test)
```

