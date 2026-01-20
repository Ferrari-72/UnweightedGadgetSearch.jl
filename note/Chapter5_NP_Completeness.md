# Chapter 5: Who is the Hardest One of All? NP-Completeness

> "Do not ask God the way to heaven; he will show you the hardest one." — Stanislaw J. Lec

## 📚 Overview

This chapter explores **NP-completeness** — a property that identifies the "hardest" problems in NP (Nondeterministic Polynomial time). If ANY NP-complete problem can be solved in polynomial time, then ALL problems in NP can be solved in polynomial time, meaning P = NP.

---

## 🔑 Key Vocabulary

| Term | Full Name | Chinese | Definition |
|------|-----------|---------|------------|
| **NP** | Nondeterministic Polynomial time | 非确定性多项式时间 | Problems where solutions can be verified in polynomial time |
| **NP-complete** | NP-complete | NP完全 | The hardest problems in NP; all NP problems reduce to them |
| **NP-hard** | NP-hard | NP困难 | At least as hard as NP-complete, but not necessarily in NP |
| **Reduction** | Polynomial-time reduction | 多项式时间归约 | Transforming problem A into problem B efficiently |
| **Witness** | Witness/Certificate | 证据/证书 | A solution that can be verified quickly |
| **SAT** | Boolean Satisfiability | 布尔可满足性 | Can a Boolean formula be made TRUE? |
| **CNF** | Conjunctive Normal Form | 合取范式 | AND of OR clauses: (x₁∨x₂)∧(x₃∨¬x₄) |
| **MIS** | Maximum Independent Set | 最大独立集 | Largest set of non-adjacent vertices |

---

## 📖 5.1 When One Problem Captures Them All

### Definition of NP-Completeness

A problem B in NP is **NP-complete** if:
1. B ∈ NP (B is in NP — solutions can be verified in polynomial time)
2. For ALL problems A ∈ NP: A ≤ₚ B (every NP problem reduces to B)

> 简单说：NP完全问题是NP中"最难"的问题。如果能快速解决任何一个NP完全问题，就能快速解决所有NP问题！

### Why This Matters

```
If ANY NP-complete problem is in P:
    → ALL NP problems are in P
    → P = NP
    
If ANY NP-complete problem requires exponential time:
    → ALL NP-complete problems require exponential time
    → P ≠ NP
```

### The First NP-Complete Problem: WITNESS EXISTENCE

**WITNESS EXISTENCE**
- Input: A program Π(x, w), an input x, and integer t (in unary)
- Question: Does there exist w with |w| ≤ t such that Π(x, w) returns "yes" in ≤ t steps?

This problem is NP-complete because it captures the very definition of NP!
> 这个问题是NP完全的，因为它直接表达了NP的定义本身。

---

## 📖 5.2 Boolean Satisfiability (SAT)

### The SAT Problem

**SAT (Boolean Satisfiability)**
- Input: A Boolean formula φ
- Question: Is there an assignment to variables making φ TRUE?

### CNF (Conjunctive Normal Form) 合取范式

A formula in CNF is an AND of clauses, where each clause is an OR of literals:

$$\phi = (x_1 \vee \neg x_2 \vee x_3) \wedge (\neg x_1 \vee x_4) \wedge (x_2 \vee \neg x_3 \vee \neg x_4)$$

**Terminology:**
- **Literal** (文字): A variable (xᵢ) or its negation (¬xᵢ)
- **Clause** (子句): An OR of literals
- **k-SAT**: SAT where each clause has exactly k literals

### Cook-Levin Theorem (库克-列文定理)

> **Theorem**: SAT is NP-complete.

This was independently proved by Stephen Cook (1971) and Leonid Levin (1973).

**Why SAT is NP-complete:**
1. SAT ∈ NP: Given an assignment, we can check if it satisfies φ in polynomial time ✓
2. Every NP problem reduces to SAT: Any polynomial-time verifier can be encoded as a Boolean circuit, then converted to a SAT formula ✓

### Variants of SAT

| Problem | Description | Complexity |
|---------|-------------|------------|
| **2-SAT** | Each clause has exactly 2 literals | P (polynomial time!) |
| **3-SAT** | Each clause has exactly 3 literals | NP-complete |
| **k-SAT** (k ≥ 3) | Each clause has exactly k literals | NP-complete |
| **Horn-SAT** | Each clause has at most 1 positive literal | P |
| **XOR-SAT** | XOR of variables instead of OR | P (linear algebra) |

> **重要**: 2-SAT是P的，但3-SAT是NP完全的！这个"从2到3"的跳跃在复杂度理论中非常常见。

---

## 📖 5.3 Graph Problems and Independent Set ⭐

### 5.3.1 Independent Set (IS) — 独立集问题

**INDEPENDENT SET (IS)**
- Input: Graph G = (V, E) and integer k
- Question: Does G have an independent set of size ≥ k?

**Definition**: An **independent set** is a set S ⊆ V where NO two vertices in S are adjacent.
> 独立集是一组顶点，其中任意两个顶点之间都没有边相连。

```
Example:
    A ─── B
    │ \   │
    │  \  │
    │   \ │
    C ─── D

Independent sets:
✓ {B, C} — no edge between B and C
✓ {A}    — single vertex is always independent
✗ {A, B} — edge exists between A and B!
✗ {A, D} — edge exists between A and D!

Maximum Independent Set (MIS): {B, C} with size 2
```

### 5.3.2 INDEPENDENT SET is NP-complete

**Proof outline:**
1. IS ∈ NP: Given a set S, verify |S| ≥ k and no edges within S — O(k²) time ✓
2. 3-SAT ≤ₚ IS: Reduce 3-SAT to Independent Set (详见下文)

### 5.3.3 Reduction: 3-SAT → INDEPENDENT SET

This is one of the most important reductions!
> 这是最重要的归约之一，展示了如何把逻辑问题转化为图问题。

**Construction (构造方法):**

Given a 3-SAT formula with m clauses:
$$\phi = C_1 \wedge C_2 \wedge \cdots \wedge C_m$$

**Step 1**: For each clause, create a triangle (3 vertices, all connected)
> 每个子句创建一个三角形

```
Clause C₁ = (x₁ ∨ ¬x₂ ∨ x₃):

    x₁ ─── ¬x₂
      \   /
       \ /
       x₃
       
(All three vertices connected to each other)
```

**Step 2**: Connect contradictory literals across different triangles
> 连接不同三角形中矛盾的文字

```
If x₁ appears in clause 1 and ¬x₁ appears in clause 2:
    Connect x₁ (in triangle 1) to ¬x₁ (in triangle 2)
```

**Step 3**: Ask for an independent set of size m (number of clauses)

**Why it works:**
```
1. Within each triangle: can select at most 1 vertex
   (因为三角形内的顶点两两相连)
   
2. Cannot select both xᵢ and ¬xᵢ: they are connected
   (不能同时选择矛盾的文字)
   
3. Independent set of size m means:
   - Exactly 1 literal selected from each clause
   - No contradictions
   - This IS a satisfying assignment!
```

**Complete Example:**

```
3-SAT Formula: (x₁ ∨ ¬x₂ ∨ x₃) ∧ (¬x₁ ∨ x₂ ∨ x₃) ∧ (x₁ ∨ x₂ ∨ ¬x₃)

Graph construction:

Clause 1:          Clause 2:          Clause 3:
   x₁                ¬x₁                x₁
   /\                /\                 /\
  /  \              /  \               /  \
¬x₂──x₃           x₂──x₃             x₂──¬x₃

Additional edges (contradictions):
- x₁ (C1) ─── ¬x₁ (C2)
- x₁ (C3) ─── ¬x₁ (C2)
- ¬x₂ (C1) ─── x₂ (C2)
- ¬x₂ (C1) ─── x₂ (C3)
- x₃ (C1) ─── ¬x₃ (C3)
- x₃ (C2) ─── ¬x₃ (C3)

Find IS of size 3? → φ is satisfiable!
Example: Select {x₁, x₂, ¬x₃} → Assignment: x₁=T, x₂=T, x₃=F
```

### 5.3.4 Related Graph Problems

| Problem | Definition | Relation to IS |
|---------|------------|----------------|
| **CLIQUE** | Find k vertices ALL connected | IS on complement graph |
| **VERTEX COVER** | Find k vertices covering all edges | V - IS |
| **GRAPH COLORING** | Color vertices with k colors | Related to IS |

**The Beautiful Duality:**
```
S is Independent Set in G  ⟺  S is Clique in Ḡ (complement)
S is Independent Set in G  ⟺  V-S is Vertex Cover in G

Therefore: IS ≡ₚ CLIQUE ≡ₚ VERTEX COVER
(They are all NP-complete and polynomially equivalent)
```

---

## 📖 5.4 More NP-Complete Problems

### The Reduction Chain

```
        CIRCUIT SAT
             │
             ↓
            SAT
             │
             ↓
          3-SAT ─────────────────────────────┐
             │                               │
             ↓                               ↓
    INDEPENDENT SET ←→ CLIQUE ←→ VERTEX COVER
             │
             ↓
     HAMILTONIAN PATH
             │
             ↓
    TRAVELING SALESMAN (TSP)
```

### Complete List of Classic NP-Complete Problems

| Problem | Input | Question |
|---------|-------|----------|
| **SAT** | Boolean formula φ | ∃ assignment making φ true? |
| **3-SAT** | CNF with 3 literals/clause | ∃ satisfying assignment? |
| **INDEPENDENT SET** | Graph G, integer k | ∃ IS of size ≥ k? |
| **CLIQUE** | Graph G, integer k | ∃ clique of size ≥ k? |
| **VERTEX COVER** | Graph G, integer k | ∃ cover of size ≤ k? |
| **GRAPH COLORING** | Graph G, integer k | ∃ k-coloring? |
| **HAMILTONIAN PATH** | Graph G | ∃ path visiting all vertices once? |
| **HAMILTONIAN CYCLE** | Graph G | ∃ cycle visiting all vertices once? |
| **TSP** (decision) | Graph G, budget B | ∃ tour with cost ≤ B? |
| **SUBSET SUM** | Set S, target t | ∃ subset summing to t? |
| **PARTITION** | Set S | ∃ partition into two equal-sum subsets? |
| **BIN PACKING** | Items, bins of capacity C | ∃ packing into k bins? |
| **TILING** | Region R, tiles T | Can R be tiled with T? |

---

## 📖 5.5 Circuit SAT and the Cook-Levin Theorem

### Boolean Circuits (布尔电路)

A Boolean circuit is a directed acyclic graph (DAG) where:
- Input nodes: variables x₁, x₂, ..., xₙ
- Internal nodes: logic gates (AND, OR, NOT)
- Output node: single output bit

```
Example circuit:
    x₁    x₂    x₃
     \   /  \   /
     AND    OR
       \   /
       AND
         │
       output
         
This computes: (x₁ ∧ x₂) ∧ (x₂ ∨ x₃)
```

### CIRCUIT SAT

**CIRCUIT SAT**
- Input: Boolean circuit C
- Question: ∃ input assignment making C output 1?

**Theorem**: CIRCUIT SAT is NP-complete.
> CIRCUIT SAT是NP完全的，而且它是证明其他问题NP完全性的基础。

### Why CIRCUIT SAT → SAT → 3-SAT?

```
CIRCUIT SAT → SAT:
    Introduce variable for each gate's output
    Add clauses enforcing gate behavior
    
SAT → 3-SAT:
    Replace long clauses with multiple 3-literal clauses
    using auxiliary variables
```

---

## 📖 5.6 Gadgets for Reductions

### What is a Gadget? (什么是Gadget?)

A **gadget** is a small structure used in reductions to enforce constraints.

> Gadget是归约中用来强制执行约束的小型结构。例如，在3-SAT到IS的归约中，三角形就是一个gadget，它强制"每个子句最多选一个文字"。

### Common Gadgets

**1. Triangle Gadget (for IS)**
```
Enforces: select at most 1 of 3 vertices
Used in: 3-SAT → IS reduction

    A
   / \
  B───C
  
Any IS can include at most 1 of {A, B, C}
```

**2. Equality Gadget**
```
Enforces: two vertices must have same value
    
    xᵢ ─── ¬xⱼ
    
If in IS, cannot select both xᵢ and ¬xⱼ
```

**3. XOR Gadget**
```
Enforces: exactly one of two must be selected
More complex construction needed
```

---

## 📖 5.7 Weighted vs Unweighted Problems

### Weighted Independent Set

**WEIGHTED INDEPENDENT SET**
- Input: Graph G with vertex weights w(v), target W
- Question: ∃ IS with total weight ≥ W?

This is also NP-complete (reduces from unweighted IS by setting all weights = 1).

### Maximum Independent Set (MIS) vs Decision IS

| Version | Question | Complexity |
|---------|----------|------------|
| Decision | ∃ IS of size ≥ k? | NP-complete |
| Optimization | Find largest IS | NP-hard |
| Counting | How many IS of size k? | #P-complete |

---

## 📝 Summary: NP-Completeness

### Key Points

1. **NP-complete problems are the hardest in NP**
   - If one is in P, then P = NP
   
2. **To prove NP-completeness:**
   - Show problem is in NP (验证解可以在多项式时间内完成)
   - Reduce from a known NP-complete problem (从已知NP完全问题归约)

3. **Independent Set is NP-complete**
   - Central to many reductions
   - Equivalent to Clique and Vertex Cover

4. **Practical implications:**
   - No known polynomial algorithms
   - Must use heuristics, approximations, or special cases

### The Big Picture

```
P ⊆ NP ⊆ PSPACE ⊆ EXPTIME

NP-complete problems sit at the "top" of NP:
- If ANY NP-complete problem is in P → P = NP
- If ANY NP-complete problem is not in P → P ≠ NP

Most computer scientists believe P ≠ NP,
meaning NP-complete problems truly require exponential time.
```

---

## 📚 References

- Cook, S. "The Complexity of Theorem-Proving Procedures" (1971)
- Karp, R. "Reducibility Among Combinatorial Problems" (1972)
- Garey & Johnson "Computers and Intractability" (1979)

---

*Previous: [Chapter 4](./Chapter4_Needles_in_Haystacks_Search.md)*

*Next: [Chapter 6 - P vs NP](./Chapter6_P_vs_NP.md)*

