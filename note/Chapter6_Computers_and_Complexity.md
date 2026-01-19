# Chapter 6: Computers and Complexity

## 📚 Overview

This chapter introduces the formal model of computation - the **Turing Machine** - and develops the mathematical framework for analyzing **computational complexity**. Understanding these concepts is essential for quantum computing research, as quantum complexity classes like **BQP** are defined relative to these classical foundations.

---

## 🔑 Key Vocabulary (科研英语词汇)

| English Term | Pronunciation | Chinese | Definition |
|-------------|---------------|---------|------------|
| **Turing Machine** | /ˈtjʊərɪŋ məˈʃiːn/ | 图灵机 | An abstract mathematical model of computation with a tape, head, and state transitions |
| **Deterministic** | /dɪˌtɜːmɪˈnɪstɪk/ | 确定性的 | A system where each state has exactly one possible next state |
| **Nondeterministic** | /ˌnɒndɪˌtɜːmɪˈnɪstɪk/ | 非确定性的 | A system that can explore multiple computational paths simultaneously |
| **Time Complexity** | /taɪm kəmˈpleksɪti/ | 时间复杂度 | The amount of time (steps) required by an algorithm as a function of input size |
| **Space Complexity** | /speɪs kəmˈpleksɪti/ | 空间复杂度 | The amount of memory required by an algorithm as a function of input size |
| **Polynomial** | /ˌpɒlɪˈnəʊmiəl/ | 多项式的 | Growing as n^k for some constant k (considered "efficient") |
| **Exponential** | /ˌekspəˈnenʃəl/ | 指数的 | Growing as k^n (considered "inefficient" or "intractable") |
| **Oracle** | /ˈɒrəkəl/ | 神谕机 | A theoretical "black box" that can solve a specific problem in one step |
| **Reduction** | /rɪˈdʌkʃən/ | 归约 | A transformation of one problem into another to compare their difficulties |
| **Completeness** | /kəmˈpliːtnəs/ | 完备性 | A problem that is "hardest" within its complexity class |

---

## 📖 Core Concepts

### 6.1 The Turing Machine

The **Turing Machine** is the mathematical foundation of all modern computers. Invented by Alan Turing in 1936, it defines what "computation" means.

#### Components of a Turing Machine:

```
┌─────────────────────────────────────────────┐
│  ... □ □ 0 1 1 0 1 □ □ ...   ← Infinite Tape
│              ↑
│           ┌──┴──┐
│           │ q₃  │              ← Finite State Control
│           └─────┘
└─────────────────────────────────────────────┘
```

1. **Tape**: An infinite sequence of cells, each containing a symbol
2. **Head**: Reads and writes symbols, moves left or right
3. **State Register**: Stores the current state from a finite set
4. **Transition Function**: δ(state, symbol) → (new_state, new_symbol, direction)

#### Formal Definition:

A Turing Machine is a 7-tuple: **M = (Q, Σ, Γ, δ, q₀, q_accept, q_reject)**

| Symbol | Meaning |
|--------|---------|
| Q | Finite set of states |
| Σ | Input alphabet (not including blank □) |
| Γ | Tape alphabet (Σ ⊆ Γ, includes □) |
| δ | Transition function: Q × Γ → Q × Γ × {L, R} |
| q₀ | Initial state |
| q_accept | Accepting state |
| q_reject | Rejecting state |

#### Example Research Sentence:
- *"We prove that this problem is decidable by constructing a Turing machine that halts on all inputs."*
- *"The transition function δ defines the computational behavior of the machine."*

---

### 6.2 Time and Space Complexity

#### Time Complexity

**Definition**: The time complexity T(n) of a Turing machine M is the maximum number of steps M takes on any input of length n.

$$T(n) = \max_{|x|=n} \{\text{steps of } M \text{ on input } x\}$$

#### Space Complexity

**Definition**: The space complexity S(n) is the maximum number of tape cells used.

$$S(n) = \max_{|x|=n} \{\text{cells used by } M \text{ on input } x\}$$

#### Big-O Notation

| Notation | Name | Example |
|----------|------|---------|
| O(1) | Constant | Array access |
| O(log n) | Logarithmic | Binary search |
| O(n) | Linear | Linear search |
| O(n log n) | Linearithmic | Merge sort |
| O(n²) | Quadratic | Bubble sort |
| O(2ⁿ) | Exponential | Brute-force SAT |

#### The Polynomial/Exponential Divide

This is the fundamental boundary between "tractable" and "intractable":

| n | n² | 2ⁿ |
|---|-----|-----|
| 10 | 100 | 1,024 |
| 20 | 400 | 1,048,576 |
| 50 | 2,500 | ~10¹⁵ |
| 100 | 10,000 | ~10³⁰ |

> **Key Insight**: Polynomial algorithms scale reasonably; exponential algorithms become impossible for large inputs.

#### Research Phrases:
- *"The algorithm runs in O(n²) time and O(n) space."*
- *"We achieve exponential speedup compared to the best known classical algorithm."*

---

### 6.3 Complexity Classes

#### The Complexity Class Hierarchy

```
                    ┌─────────────┐
                    │   EXPSPACE  │
                    └──────┬──────┘
                           │
                    ┌──────┴──────┐
                    │    PSPACE   │
                    └──────┬──────┘
                           │
              ┌────────────┼────────────┐
              │            │            │
        ┌─────┴─────┐ ┌────┴────┐ ┌─────┴─────┐
        │    NP     │ │   BQP   │ │   co-NP   │
        └─────┬─────┘ └────┬────┘ └─────┬─────┘
              │            │            │
              └────────────┼────────────┘
                           │
                    ┌──────┴──────┐
                    │      P      │
                    └─────────────┘
```

#### Class P (Polynomial Time)

**Definition**: P is the class of decision problems solvable by a deterministic Turing machine in polynomial time.

$$P = \bigcup_{k \geq 1} \text{TIME}(n^k)$$

**Examples in P:**
- Sorting
- Shortest path (Dijkstra's algorithm)
- Linear programming
- Primality testing (AKS algorithm)

#### Class NP (Nondeterministic Polynomial Time)

**Definition**: NP is the class of decision problems where "yes" instances have certificates verifiable in polynomial time.

**Equivalent Definition**: Problems solvable by a nondeterministic Turing machine in polynomial time.

**Examples in NP:**
- Boolean Satisfiability (SAT)
- Graph Coloring
- Hamiltonian Path
- Integer Factorization

#### Class PSPACE

**Definition**: Problems solvable using polynomial space (but possibly exponential time).

$$PSPACE = \bigcup_{k \geq 1} \text{SPACE}(n^k)$$

**Important Result**: PSPACE = NPSPACE (Savitch's Theorem)

**Examples:**
- Quantified Boolean Formula (QBF)
- Generalized Chess
- Regular Expression Equivalence

---

### 6.4 NP-Completeness

#### Definition

A problem L is **NP-complete** if:
1. L ∈ NP (solutions can be verified in polynomial time)
2. Every problem in NP can be polynomial-time reduced to L

#### The Cook-Levin Theorem

> **Theorem**: SAT (Boolean Satisfiability) is NP-complete.

This was the first problem proven NP-complete (1971).

#### Common NP-Complete Problems

| Problem | Description |
|---------|-------------|
| **SAT** | Is there an assignment making a Boolean formula true? |
| **3-SAT** | SAT with clauses of exactly 3 literals |
| **CLIQUE** | Does graph G have a clique of size k? |
| **VERTEX COVER** | Can k vertices cover all edges? |
| **HAMILTONIAN PATH** | Is there a path visiting all vertices exactly once? |
| **SUBSET SUM** | Is there a subset summing to target t? |
| **GRAPH COLORING** | Can G be colored with k colors? |

#### Reduction Chain

```
SAT → 3-SAT → CLIQUE → VERTEX COVER → HAMILTONIAN PATH
                ↓
          INDEPENDENT SET
```

#### Research Phrases:
- *"We prove NP-hardness by reduction from 3-SAT."*
- *"Unless P = NP, no polynomial-time algorithm exists for this problem."*

---

## 🔬 Connection to Quantum Computing

### 6.5 Quantum Complexity Classes

#### BQP (Bounded-error Quantum Polynomial time)

**Definition**: The class of decision problems solvable by a quantum computer in polynomial time with error probability ≤ 1/3.

**Key Properties:**
- P ⊆ BQP ⊆ PSPACE
- BQP is believed to be incomparable with NP

#### Problems in BQP (but not known to be in P):

| Problem | Best Classical | Quantum |
|---------|---------------|---------|
| Integer Factorization | O(exp(n^{1/3})) | O(n³) - Shor's |
| Discrete Logarithm | O(exp(n^{1/2})) | O(n³) - Shor's |
| Unstructured Search | O(N) | O(√N) - Grover's |
| Simulation of Quantum Systems | Exponential | Polynomial |

#### QMA (Quantum Merlin-Arthur)

**Definition**: The quantum analog of NP - problems where a quantum proof can be verified by a quantum computer.

- NP ⊆ QMA ⊆ PSPACE
- QMA-complete problems exist (e.g., Local Hamiltonian)

### 6.6 The Power and Limits of Quantum Computing

#### What Quantum Computers CAN Do Better:
1. **Factoring** (Shor's algorithm) - Exponential speedup
2. **Unstructured search** (Grover's algorithm) - Quadratic speedup
3. **Quantum simulation** - Exponential speedup
4. **Some optimization problems** - Potential speedup

#### What Quantum Computers Probably CANNOT Do:
1. Solve NP-complete problems efficiently (unless NP ⊆ BQP)
2. Violate the Church-Turing thesis
3. Solve undecidable problems

#### The Oracle Separation

> **Theorem** (Bennett et al., 1997): There exists an oracle A such that NP^A ⊄ BQP^A.

This suggests that quantum computers probably cannot solve all NP problems efficiently.

---

## 📊 Summary Table: Complexity Classes

| Class | Definition | Example Problem | Quantum Relation |
|-------|------------|-----------------|------------------|
| P | Poly-time deterministic | Sorting | P ⊆ BQP |
| NP | Poly-time verifiable | SAT | NP ⊆ QMA |
| BQP | Poly-time quantum | Factoring | Core quantum class |
| QMA | Quantum verifiable | Local Hamiltonian | Quantum NP |
| PSPACE | Poly-space | QBF | BQP ⊆ PSPACE |

---

## 📝 Practice Exercises

### Exercise 1: Complexity Classification
Classify each algorithm's time complexity:

1. Binary search on sorted array
2. Checking all 2ⁿ subsets
3. Matrix multiplication (naive)
4. Shor's factoring algorithm

<details>
<summary>Answers</summary>

1. O(log n) - Logarithmic
2. O(2ⁿ) - Exponential  
3. O(n³) - Polynomial (Cubic)
4. O(n³) - Polynomial on a quantum computer

</details>

### Exercise 2: Research Writing
Rewrite in academic English:

*"This problem is super hard, even quantum computers probably can't solve it fast."*

<details>
<summary>Suggested Answer</summary>

*"This problem is believed to be intractable even for quantum computers, as it lies outside BQP unless unexpected complexity class collapses occur."*

</details>

### Exercise 3: Reduction Understanding
If problem A reduces to problem B in polynomial time, and B ∈ P, what can we conclude about A?

<details>
<summary>Answer</summary>

A ∈ P. Since A ≤_p B and B ∈ P, we can solve A by:
1. Converting A to B (polynomial time)
2. Solving B (polynomial time)
Total: polynomial time, so A ∈ P.

</details>

---

## 🔑 Key Takeaways

1. **Turing Machines** provide the mathematical definition of computation
2. **Time complexity** measures algorithm efficiency as input grows
3. **P vs NP** is the central open problem in complexity theory
4. **NP-complete** problems are the "hardest" problems in NP
5. **BQP** defines what quantum computers can solve efficiently
6. **Quantum speedup** is problem-specific, not universal

---

## 📚 Further Reading

- Sipser, M. "Introduction to the Theory of Computation" - Chapter 3-7
- Arora & Barak "Computational Complexity: A Modern Approach" - Chapters 1-6
- Nielsen & Chuang "Quantum Computation and Quantum Information" - Chapter 4
- Watrous, J. "Quantum Computational Complexity" - Survey paper

---

*Previous: [Chapter 5 - Cryptography](./Chapter5_Hiding_in_Plain_Sight_Cryptography.md)*

*Next: [Chapter 7 - Universality and Undecidability](./Chapter7_Universality_and_Undecidability.md)*

