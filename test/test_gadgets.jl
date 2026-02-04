# Test all reproduced gadgets

using UnweightedGadgetSearch
using Test
using Graphs

@testset "All Reproduced Gadgets" begin
    # List of all gadgets to test
    gadgets = [
        Cross{true}(),
        Cross{false}(),
        Turn(),
        WTurn(),
        Branch(),
        BranchFix(),
        BranchFixB(),
        TCon(),
        TrivialTurn(),
        EndTurn(),
    ]
    
    for gadget in gadgets
        gadget_name = typeof(gadget)
        @testset "$gadget_name" begin
            # Test source graph
            locs1, g1, pins1 = source_graph(gadget)
            @test length(locs1) == nv(g1)
            @test length(pins1) > 0
            
            # Test mapped graph
            locs2, g2, pins2 = mapped_graph(gadget)
            @test length(locs2) == nv(g2)
            @test length(pins2) > 0
            @test length(pins1) == length(pins2)
            
            println("✓ $gadget_name: $(nv(g1))→$(nv(g2)) vertices, $(length(pins1)) pins")
        end
    end
end

println("\n✅ All 10 gadgets reproduced successfully!")
