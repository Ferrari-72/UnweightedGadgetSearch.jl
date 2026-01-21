# 复习问题与答案 (Review Questions & Answers)

> 整理自《The Nature of Computation》第3-6章学习笔记

---

## Part 1: 基础概念 (Basic Concepts)

### Q1: P和NP的定义是什么？

**Answer:**
- **P (Polynomial time)**: 可以在多项式时间内**求解**的判定问题
- **NP (Nondeterministic Polynomial time)**: 可以在多项式时间内**验证**答案的判定问题

**Key insight**: P ⊆ NP，但是否 P = NP 是未解问题。

> 中文：P是能快速解决的问题，NP是能快速验证答案的问题。

---

### Q2: 什么是Witness和Verifier？

**Answer:**
- **Witness (证据/证书)**: 证明"YES"实例的解
- **Verifier (验证器)**: 在多项式时间内检查witness的算法

**Formal definition**: L ∈ NP iff ∃ polynomial p(n) and polynomial-time V such that:
$$x \in L \Leftrightarrow \exists w, |w| \leq p(|x|): V(x,w) = \text{YES}$$

---

### Q3: NP的不对称性体现在哪里？

**Answer:**
- YES实例：有短证明（witness）
- NO实例：可能没有短证明！

**Example**: HAMILTONIAN PATH
- YES: 给出路径即可验证
- NO: 如何证明所有路径都不行？需要检查指数多种可能

---

## Part 2: NP完全性 (NP-Completeness)

### Q4: NP完全的定义是什么？

**Answer:**
问题B是NP完全的，当且仅当：
1. B ∈ NP
2. ∀A ∈ NP: A ≤ₚ B （所有NP问题都能多项式归约到B）

**Significance**: 如果任何NP完全问题在P中，则P = NP。

---

### Q5: 3-SAT → Independent Set 归约怎么做？

**Answer:**

**构造方法:**

1. **子句→三角形**: 每个子句的3个文字对应3个顶点，两两相连
2. **矛盾→边**: 不同三角形中的矛盾文字（xᵢ和¬xᵢ）之间连边
3. **问题**: 是否存在大小为m（子句数）的独立集？

**为什么正确:**
- 三角形内最多选1个顶点
- 矛盾文字不能同时选
- 大小为m的IS = 每个子句选一个真文字 = 可满足赋值

**Example:**
```
φ = (x₁ ∨ ¬x₂ ∨ x₃) ∧ (¬x₁ ∨ x₂ ∨ x₄)

    Triangle 1:          Triangle 2:
       x₁                   ¬x₁
      /  \                 /   \
    ¬x₂──x₃              x₂───x₄

    Additional edge: x₁ ── ¬x₁
```

---

### Q6: Independent Set、Clique、Vertex Cover的关系？

**Answer:**

| 关系 | 表达式 |
|------|--------|
| IS ↔ Clique | S是G的IS ⟺ S是Ḡ的Clique |
| IS ↔ VC | S是G的IS ⟺ V-S是G的VC |

**Complement Graph (补图)**: Ḡ在G有边的地方没边，没边的地方有边。

这三个问题多项式等价：IS ≡ₚ Clique ≡ₚ Vertex Cover

---

### Q7: 为什么2-SAT在P中，3-SAT是NP完全的？

**Answer:**

**2-SAT in P:**
- 每个子句(a∨b)等价于两个蕴含: ¬a→b, ¬b→a
- 构建蕴含图
- 用强连通分量算法检查是否∃变量x: x和¬x在同一SCC
- 时间: O(n + m)

**3-SAT is NP-complete:**
- Cook-Levin定理: 任何NP问题可归约到SAT
- SAT可归约到3-SAT（用辅助变量拆分长子句）

> 关键洞察：从2到3的跳跃在复杂度理论中频繁出现！

---

## Part 3: P vs NP (核心问题)

### Q8: 证明P≠NP的三大障碍是什么？

**Answer:**

| 障碍 | 年份 | 排除的技术 |
|------|------|-----------|
| **Relativization** | 1975 | 对角化、模拟论证 |
| **Natural Proofs** | 1997 | 组合式下界证明 |
| **Algebrization** | 2008 | 算术扩展技术 |

**Relativization (相对化):**
- 存在oracle A使P^A = NP^A
- 存在oracle B使P^B ≠ NP^B
- 因此纯粹的对角化无法解决

**Natural Proofs (自然证明):**
- 如果单向函数存在，自然证明无法证P≠NP

---

### Q9: 如果P = NP，会发生什么？

**Answer:**

1. **多项式谱系坍缩**: P = NP = coNP = PH
2. **密码学崩溃**: 所有基于计算困难性的密码都不安全
3. **自动证明**: 寻找数学证明和验证一样简单
4. **创造力机械化**: "创造"和"判断"一样容易

> 大多数专家(~80%)相信P ≠ NP

---

### Q10: 什么是Polynomial Hierarchy (多项式谱系)？

**Answer:**

$$\Sigma_0^P = \Pi_0^P = P$$
$$\Sigma_1^P = NP \quad (\exists \text{ quantifier})$$
$$\Pi_1^P = coNP \quad (\forall \text{ quantifier})$$
$$\Sigma_{k+1}^P: \text{Add } \exists \text{ to } \Pi_k^P$$
$$\Pi_{k+1}^P: \text{Add } \forall \text{ to } \Sigma_k^P$$
$$PH = \bigcup_k (\Sigma_k^P \cup \Pi_k^P)$$

**Example (Π₂P):** SMALLEST CIRCUIT
- 输入: 电路C
- 问题: C是否是计算其函数的最小电路？
- 表达: ∀C' < C: ∃x: f_C'(x) ≠ f_C(x)

---

## Part 4: 算法技术 (Algorithm Techniques)

### Q11: 动态规划解决树上Independent Set的方法？

**Answer:**

**定义状态:**
- `include[v]` = 包含v的子树最大IS
- `exclude[v]` = 不包含v的子树最大IS

**递推关系:**
```
include[v] = 1 + Σ exclude[child]    // v选了，孩子不能选
exclude[v] = Σ max(include[child], exclude[child])
```

**时间复杂度:** O(n)

> 重要：树上IS是P的，一般图上是NP完全的！

---

### Q12: Independent Set在哪些图类上可以高效求解？

**Answer:**

| 图类 | 复杂度 | 算法 |
|------|--------|------|
| 树 | O(n) | 动态规划 |
| 二分图 | O(√n × m) | König定理 + 匹配 |
| 区间图 | O(n log n) | 贪心 |
| 弦图 | O(n + m) | 完美消除序列 |
| 平面图(fixed k) | O(n) | Baker技术 |
| 一般图 | NP-complete | 指数算法 |

---

## Part 5: 量子计算相关 (Quantum Computing)

### Q13: 量子计算机能解决NP完全问题吗？

**Answer:**

**可能不能!**

- Grover算法: 搜索从O(N)加速到O(√N)，只是平方加速
- NP完全问题: 从2^n到2^(n/2)，仍然是指数

**BQP vs NP:**
- P ⊆ BQP ⊆ PSPACE
- P ⊆ NP ⊆ PSPACE
- BQP和NP的关系未知，可能不可比较

| 问题 | 经典 | 量子 |
|------|------|------|
| FACTORING | 次指数 | 多项式(Shor) |
| NP-complete | 指数 | 指数(可能) |

---

### Q14: 什么是QMA？

**Answer:**

**QMA (Quantum Merlin-Arthur)** = 量子版的NP
- YES实例有**量子**witness
- 由量子计算机验证

**QMA-complete问题:** Local Hamiltonian Problem（量子版的SAT）

---

## Summary Table: NP-Complete Problems

| 问题 | 输入 | 问题 | Witness |
|------|------|------|---------|
| SAT | 布尔公式φ | φ可满足？ | 赋值 |
| 3-SAT | CNF(3文字/子句) | 可满足？ | 赋值 |
| INDEPENDENT SET | 图G，整数k | ∃IS ≥ k？ | 顶点集 |
| CLIQUE | 图G，整数k | ∃Clique ≥ k？ | 顶点集 |
| VERTEX COVER | 图G，整数k | ∃VC ≤ k？ | 顶点集 |
| HAMILTONIAN PATH | 图G | ∃哈密顿路径？ | 路径 |
| TSP | 图G，预算B | ∃旅程 ≤ B？ | 旅程 |
| SUBSET SUM | 集合S，目标t | ∃子集和=t？ | 子集 |

---

*Last updated: 2026-01-21*

*Part of: The Nature of Computation Study Notes*

