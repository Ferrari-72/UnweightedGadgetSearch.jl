# 补充问答记录 (Supplementary Q&A Session)

> 学习过程中的问题与解答整理

---

## Q1: What is Sudoku? How does it relate to SAT?

### Answer:

**Sudoku (数独)** is a logic puzzle:
- 9×9 grid divided into 3×3 boxes
- Fill digits 1-9 so each row, column, and box contains each digit exactly once

**Connection to SAT:**

Sudoku can be encoded as a SAT problem:
- Variables: x_{i,j,k} = "cell (i,j) contains digit k"
- Constraints become clauses:
  - Each cell has at least one digit: (x_{i,j,1} ∨ x_{i,j,2} ∨ ... ∨ x_{i,j,9})
  - Each cell has at most one digit: (¬x_{i,j,k} ∨ ¬x_{i,j,l}) for k ≠ l
  - Each row has each digit: similar clauses
  - Each column has each digit: similar clauses
  - Each 3×3 box has each digit: similar clauses

> 数独可以编码成SAT问题：每个格子用9个布尔变量表示可能的数字，约束条件转化为子句。

**Complexity:**
- General n×n Sudoku: NP-complete
- Standard 9×9 Sudoku: can be solved quickly in practice

---

## Q2: What does "reduces to" mean? (什么是"归约")

### Answer:

**Reduction (归约)** means transforming one problem into another.

**Formal Definition:**
Problem A **reduces to** problem B (written A ≤ₚ B) if:
- There exists a polynomial-time function f such that:
- x ∈ A ⟺ f(x) ∈ B

**Meaning:**
- "A is no harder than B"
- If we can solve B, we can solve A
- If A is hard, then B is also hard

```
Problem A ──────────→ Problem B
   │                     │
   │ f (polynomial)      │ Solve B
   ↓                     ↓
Instance of A ──→ Instance of B ──→ Answer
```

**Example: 3-SAT reduces to Independent Set**
- Input: 3-SAT formula φ
- Output: Graph G, integer k
- φ is satisfiable ⟺ G has independent set of size k

> 归约的意思是：把问题A转化成问题B，使得A有解当且仅当B有解。如果转化过程是多项式时间的，就叫多项式归约。

---

## Q3: 缩写术语表 (Abbreviations)

| Abbreviation | Full Name | Chinese | Meaning |
|--------------|-----------|---------|---------|
| **SAT** | Boolean Satisfiability | 布尔可满足性 | 能否让公式为真？ |
| **CNF** | Conjunctive Normal Form | 合取范式 | AND of ORs |
| **DNF** | Disjunctive Normal Form | 析取范式 | OR of ANDs |
| **NP** | Nondeterministic Polynomial | 非确定性多项式 | 可快速验证的问题 |
| **P** | Polynomial time | 多项式时间 | 可快速求解的问题 |
| **coNP** | Complement of NP | NP的补类 | "否"答案可快速验证 |
| **IS** | Independent Set | 独立集 | 无边相连的顶点集 |
| **MIS** | Maximum Independent Set | 最大独立集 | 最大的独立集 |
| **VC** | Vertex Cover | 顶点覆盖 | 覆盖所有边的顶点集 |
| **TSP** | Traveling Salesman Problem | 旅行商问题 | 最短访问所有城市 |
| **DP** | Dynamic Programming | 动态规划 | 子问题+记忆化 |
| **BFS** | Breadth-First Search | 广度优先搜索 | 层序遍历 |
| **DFS** | Depth-First Search | 深度优先搜索 | 深入后回溯 |
| **DPLL** | Davis-Putnam-Logemann-Loveland | DPLL算法 | SAT求解算法 |
| **CDCL** | Conflict-Driven Clause Learning | 冲突驱动子句学习 | 现代SAT求解器 |
| **BQP** | Bounded-error Quantum Polynomial | 有界错误量子多项式 | 量子计算复杂类 |
| **QMA** | Quantum Merlin-Arthur | 量子MA | 量子版NP |
| **PH** | Polynomial Hierarchy | 多项式谱系 | 复杂度层次 |

---

## Q4: DPLL算法详解

### What is DPLL?

**DPLL (Davis-Putnam-Logemann-Loveland)** is a complete SAT solver algorithm from 1962.

### Key Techniques (关键技术):

**1. Unit Propagation (单元传播)**

If a clause has only ONE unassigned literal, that literal MUST be true.

```
Example:
Clause: (x₁)        ← only x₁, so x₁ must be TRUE
Clause: (¬x₂ ∨ x₃)  ← if x₃=FALSE, then ¬x₂ must be TRUE, so x₂=FALSE
```

> 如果一个子句只剩一个未赋值的文字，那个文字必须为真才能满足这个子句。

**2. Pure Literal Elimination (纯文字消除)**

If a variable appears in only ONE polarity (only positive or only negative), set it to make all its clauses true.

```
Example:
If x₃ appears only as x₃ (never as ¬x₃):
    Set x₃ = TRUE
    All clauses containing x₃ become satisfied
```

> 如果一个变量只以一种形式出现（只有x或只有¬x），直接设置它使所有相关子句为真。

**3. Branching (分支)**

Choose an unassigned variable and try both values (TRUE and FALSE).

```
DPLL(φ):
    if φ is empty: return SAT
    if φ has empty clause: return UNSAT
    
    Apply unit propagation
    Apply pure literal elimination
    
    Choose variable x
    if DPLL(φ[x=TRUE]) == SAT: return SAT
    if DPLL(φ[x=FALSE]) == SAT: return SAT
    return UNSAT
```

> 选一个变量，分别尝试TRUE和FALSE，递归求解。

---

## Q5: CDCL算法详解

### What is CDCL?

**CDCL (Conflict-Driven Clause Learning)** is the modern SAT solving technique used in state-of-the-art solvers.

### Key Improvements over DPLL:

**1. Conflict Analysis & Clause Learning (冲突分析与子句学习)**

When a conflict occurs, analyze WHY it happened and learn a new clause to prevent similar conflicts.

```
Example:
Assignments: x₁=T, x₂=T, x₃=F led to conflict

Analysis reveals: the conflict happened because x₁=T and x₂=T together

Learn new clause: (¬x₁ ∨ ¬x₂)
Add this to the formula to avoid repeating this mistake!
```

> 当发生冲突时，分析原因并学习一个新子句，避免重复同样的错误。

**2. Non-chronological Backtracking (非时序回溯)**

Don't just backtrack one step — jump back to the decision level that caused the conflict.

```
Traditional (DPLL):
    Level 1: x₁=T
    Level 2: x₂=T  
    Level 3: x₃=F  ← conflict!
    Backtrack to Level 2, try x₃=T
    
CDCL:
    Level 1: x₁=T
    Level 2: x₂=T
    Level 3: x₃=F  ← conflict!
    Analysis: conflict caused by Level 1 decision
    Jump back to Level 1, try x₁=F
```

> 不是一步一步回退，而是直接跳回到导致冲突的决策层。

**3. Restarts (重启)**

Periodically reset the search but KEEP the learned clauses.

```
Why?
- Early decisions might be bad
- Learned clauses help future searches
- Prevents getting stuck in bad parts of search space
```

> 定期重启搜索，但保留学到的子句。这样可以避免陷入搜索空间的坏区域。

---

## Q6: Local Search for SAT (局部搜索)

### What is Local Search?

Instead of systematic search, start with a random assignment and iteratively improve it.

### Key Algorithms:

**1. GSAT (Greedy SAT)**
```
1. Start with random assignment
2. Flip the variable that satisfies the most unsatisfied clauses
3. Repeat until solution found or max iterations reached
```

**2. WalkSAT**
```
1. Start with random assignment
2. Pick an unsatisfied clause randomly
3. With probability p: flip a random variable in that clause
   With probability 1-p: flip the variable that minimizes unsatisfied clauses
4. Repeat
```

> 局部搜索从随机赋值开始，不断翻转变量来改进。

### Comparison:

| Method | Complete? | Best for |
|--------|-----------|----------|
| DPLL/CDCL | Yes (完备) | Proving UNSAT, structured instances |
| Local Search | No (不完备) | Finding solutions in random instances |

---

## Q7: 如何理解"从2到3的跳跃"？

### The 2-to-3 Jump

Many problems show a sharp transition from "easy" to "hard" when a parameter increases from 2 to 3:

| Problem | k=2 | k=3 |
|---------|-----|-----|
| k-SAT | P | NP-complete |
| k-COLORING | P | NP-complete |
| k-DIMENSIONAL MATCHING | P | NP-complete |

**Why?**
- 2-SAT: can model with implications (implication graph)
- 3-SAT: cannot reduce to graph reachability, truly requires search

> 很多问题在参数从2变到3时，复杂度从P跳到NP完全。这是复杂度理论中的重要现象。

---

## Summary: Key Concepts for Research

### SAT Solving Evolution:

```
1960s: DPLL
    ↓
1990s: CDCL + Clause Learning
    ↓
2000s: Modern solvers (MiniSat, Glucose, etc.)
    ↓
Now: Can solve instances with millions of variables!
```

### When to Use What:

| Situation | Approach |
|-----------|----------|
| Need guaranteed answer | CDCL solver |
| Need to prove UNSAT | CDCL solver |
| Random satisfiable instance | Local search |
| Structured/industrial instance | CDCL solver |
| Very large instance | Parallel/distributed solving |

---

*This document compiles questions asked during the study of "The Nature of Computation".*

*Last updated: 2026-01-21*

