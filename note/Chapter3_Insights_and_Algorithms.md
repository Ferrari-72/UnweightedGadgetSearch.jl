# Chapter 3: Insights and Algorithms

> "The best way to have a good idea is to have lots of ideas." — Linus Pauling

## 📚 Overview

This chapter covers fundamental algorithmic techniques and the mathematical insights that make efficient computation possible. We explore how clever ideas can dramatically reduce computation time, from exponential to polynomial or even linear.

---

## 🔑 Key Vocabulary

| Term | Full Name | Chinese | Definition |
|------|-----------|---------|------------|
| **Algorithm** | Algorithm | 算法 | Step-by-step procedure to solve a problem |
| **Time Complexity** | Time Complexity | 时间复杂度 | How runtime grows with input size |
| **Space Complexity** | Space Complexity | 空间复杂度 | How memory usage grows with input size |
| **Polynomial** | Polynomial time | 多项式时间 | O(n^k) for some constant k |
| **Exponential** | Exponential time | 指数时间 | O(2^n) or worse |
| **Divide & Conquer** | Divide and Conquer | 分治法 | Split problem, solve parts, combine |
| **DP** | Dynamic Programming | 动态规划 | Solve subproblems, store results |
| **Greedy** | Greedy Algorithm | 贪心算法 | Make locally optimal choice at each step |
| **Recurrence** | Recurrence Relation | 递推关系 | Define T(n) in terms of T(smaller) |

---

## 📖 3.1 Big-O Notation (大O记号)

### Definition

**Big-O notation** describes the **upper bound** of an algorithm's growth rate.

$$f(n) = O(g(n)) \text{ if } \exists c, n_0: \forall n \geq n_0, f(n) \leq c \cdot g(n)$$

> 大O记号描述算法运行时间随输入规模增长的上界。O(n²)意味着运行时间最多是n²的常数倍。

### Common Complexity Classes

| Notation | Name | Chinese | Example |
|----------|------|---------|---------|
| O(1) | Constant | 常数 | Array access |
| O(log n) | Logarithmic | 对数 | Binary search |
| O(n) | Linear | 线性 | Linear search |
| O(n log n) | Linearithmic | 线性对数 | Merge sort |
| O(n²) | Quadratic | 平方 | Bubble sort |
| O(n³) | Cubic | 立方 | Matrix multiplication (naive) |
| O(2^n) | Exponential | 指数 | Brute-force SAT |
| O(n!) | Factorial | 阶乘 | Brute-force TSP |

### Growth Comparison

```
n       | log n | n    | n log n | n²      | 2^n
--------|-------|------|---------|---------|--------
10      | 3     | 10   | 33      | 100     | 1024
100     | 7     | 100  | 664     | 10000   | 10^30
1000    | 10    | 1000 | 9966    | 10^6    | 10^301
10000   | 13    | 10^4 | 132877  | 10^8    | 10^3010
```

> 看这个表格！n=100时，2^n已经大于宇宙中原子的数量。这就是为什么指数算法在实践中不可行。

---

## 📖 3.2 Divide and Conquer (分治法)

### The Strategy

1. **Divide**: Split problem into smaller subproblems
2. **Conquer**: Solve subproblems recursively
3. **Combine**: Merge solutions

```
Original Problem
     │
     ├──→ Subproblem 1 ──→ Solution 1 ──┐
     │                                   │
     ├──→ Subproblem 2 ──→ Solution 2 ──┼──→ Combined Solution
     │                                   │
     └──→ Subproblem 3 ──→ Solution 3 ──┘
```

### Example: Merge Sort

```python
def merge_sort(arr):
    if len(arr) <= 1:
        return arr
    
    mid = len(arr) // 2
    left = merge_sort(arr[:mid])     # Divide
    right = merge_sort(arr[mid:])    # Divide
    
    return merge(left, right)         # Combine

# Time: T(n) = 2T(n/2) + O(n) = O(n log n)
```

### Master Theorem (主定理)

For recurrences of form: T(n) = aT(n/b) + O(n^d)

| Condition | Result |
|-----------|--------|
| d > log_b(a) | T(n) = O(n^d) |
| d = log_b(a) | T(n) = O(n^d log n) |
| d < log_b(a) | T(n) = O(n^(log_b a)) |

**Example (Merge Sort):**
- a = 2 (two subproblems)
- b = 2 (each half the size)
- d = 1 (linear merge)
- log₂(2) = 1 = d → T(n) = O(n log n) ✓

---

## 📖 3.3 Dynamic Programming (动态规划)

### The Strategy

1. Define subproblems
2. Find recurrence relation
3. Solve subproblems in correct order
4. Store results (memoization 记忆化 or tabulation 制表法)

> 动态规划的核心思想：把问题分解成重叠子问题，存储子问题的解避免重复计算。

### Example: Fibonacci Numbers

**Naive Recursion** (exponential):
```python
def fib(n):
    if n <= 1:
        return n
    return fib(n-1) + fib(n-2)  # O(2^n) - very slow!
```

**Dynamic Programming** (linear):
```python
def fib_dp(n):
    if n <= 1:
        return n
    dp = [0] * (n + 1)
    dp[1] = 1
    for i in range(2, n + 1):
        dp[i] = dp[i-1] + dp[i-2]  # O(n) - much better!
    return dp[n]
```

### Classic DP Problems

| Problem | Subproblem Definition | Complexity |
|---------|----------------------|------------|
| Fibonacci | fib(n) = fib(n-1) + fib(n-2) | O(n) |
| Longest Common Subsequence | LCS(i,j) = longest for prefixes | O(mn) |
| Knapsack (0/1) | K(i,w) = max value using items 1..i, capacity w | O(nW) |
| Shortest Paths | dist(v) = min distance to vertex v | O(VE) |
| Matrix Chain | M(i,j) = min cost to multiply matrices i..j | O(n³) |

### Example: Independent Set on Trees ⭐

For **Maximum Independent Set on trees** (not general graphs!), we can use DP:

```
Define:
- include[v] = max IS size in subtree rooted at v, including v
- exclude[v] = max IS size in subtree rooted at v, excluding v

Recurrence:
- include[v] = 1 + Σ exclude[child] for each child of v
- exclude[v] = Σ max(include[child], exclude[child]) for each child

Answer: max(include[root], exclude[root])
```

> 在树上，独立集问题可以用DP在O(n)时间内解决！但在一般图上，它是NP完全的。这说明图的结构对问题难度有巨大影响。

**Time Complexity**: O(n) for trees

```
Example Tree:
        A
       / \
      B   C
     / \   \
    D   E   F

include[D] = 1, exclude[D] = 0
include[E] = 1, exclude[E] = 0
include[F] = 1, exclude[F] = 0

include[B] = 1 + exclude[D] + exclude[E] = 1 + 0 + 0 = 1
exclude[B] = max(1,0) + max(1,0) = 2

include[C] = 1 + exclude[F] = 1 + 0 = 1
exclude[C] = max(1,0) = 1

include[A] = 1 + exclude[B] + exclude[C] = 1 + 2 + 1 = 4
exclude[A] = max(1,2) + max(1,1) = 2 + 1 = 3

Maximum IS size = max(4, 3) = 4
The MIS is {A, D, E, F} or {B, F, ...}
```

---

## 📖 3.4 Greedy Algorithms (贪心算法)

### The Strategy

At each step, make the **locally optimal** choice, hoping it leads to a global optimum.

> 贪心算法在每一步都做出当前看起来最优的选择。但贪心不总是有效——它只对某些问题有效。

### When Greedy Works

Greedy works when the problem has:
1. **Greedy choice property**: Local optimum leads to global optimum
2. **Optimal substructure**: Optimal solution contains optimal solutions to subproblems

### Example: Activity Selection

**Problem**: Given activities with start/end times, select maximum non-overlapping activities.

**Greedy strategy**: Always pick the activity that **ends earliest**.

```
Activities: [(1,4), (3,5), (0,6), (5,7), (3,9), (5,9), (6,10), (8,11), (8,12), (2,14)]

Sorted by end time: [(1,4), (3,5), (0,6), (5,7), (3,9), (5,9), (6,10), (8,11), (8,12), (2,14)]

Selection:
1. Pick (1,4) ✓
2. Skip (3,5) - overlaps
3. Skip (0,6) - overlaps
4. Pick (5,7) ✓
5. Skip (3,9) - overlaps
...
Result: {(1,4), (5,7), (8,11)} - 3 activities
```

### Example: Minimum Vertex Cover Approximation

**2-Approximation for Vertex Cover:**
```python
def approx_vertex_cover(G):
    cover = set()
    edges = set(G.edges)
    while edges:
        (u, v) = edges.pop()  # Pick any edge
        cover.add(u)
        cover.add(v)
        # Remove all edges incident to u or v
        edges = {e for e in edges if u not in e and v not in e}
    return cover
```

> 这个贪心算法给出的顶点覆盖最多是最优解的2倍。这是已知最好的多项式时间近似算法，除非P=NP，否则无法做得更好！

**Analysis:**
- Each edge selected adds 2 vertices to cover
- Optimal must include at least 1 vertex per selected edge
- Therefore: |greedy| ≤ 2 × |optimal|

### When Greedy Fails: Independent Set

**Greedy for IS**: Pick vertex with minimum degree, remove it and neighbors, repeat.

```
Example where greedy fails:

    A ─── B ─── C ─── D ─── E
          │           │
          F           G

Greedy might pick A (degree 1), then C (degree 2), then E (degree 1)
Result: {A, C, E} size 3

But optimal is: {A, F, G, E} size 4!
```

> 贪心算法对独立集问题不保证最优解。实际上，独立集问题的近似比已知下界是n^(1-ε)，意味着任何多项式算法都无法保证好的近似。

---

## 📖 3.5 Graph Algorithms (图算法)

### Breadth-First Search (BFS) — 广度优先搜索

**Strategy**: Explore all vertices at current depth before going deeper.

```python
def bfs(graph, start):
    visited = {start}
    queue = [start]
    while queue:
        vertex = queue.pop(0)
        for neighbor in graph[vertex]:
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append(neighbor)
    return visited

# Time: O(V + E)
```

**Applications:**
- Shortest path in unweighted graphs
- Finding connected components
- Testing bipartiteness

### Depth-First Search (DFS) — 深度优先搜索

**Strategy**: Go as deep as possible, then backtrack.

```python
def dfs(graph, start, visited=None):
    if visited is None:
        visited = set()
    visited.add(start)
    for neighbor in graph[start]:
        if neighbor not in visited:
            dfs(graph, neighbor, visited)
    return visited

# Time: O(V + E)
```

**Applications:**
- Cycle detection
- Topological sorting
- Finding strongly connected components

### Dijkstra's Algorithm — 迪杰斯特拉算法

**Problem**: Shortest paths from source to all vertices (non-negative weights).

```python
import heapq

def dijkstra(graph, start):
    dist = {v: float('inf') for v in graph}
    dist[start] = 0
    pq = [(0, start)]
    
    while pq:
        d, u = heapq.heappop(pq)
        if d > dist[u]:
            continue
        for v, weight in graph[u]:
            if dist[u] + weight < dist[v]:
                dist[v] = dist[u] + weight
                heapq.heappush(pq, (dist[v], v))
    
    return dist

# Time: O((V + E) log V) with binary heap
```

---

## 📖 3.6 Searching and Sorting

### Sorting Algorithms Comparison

| Algorithm | Best | Average | Worst | Space | Stable |
|-----------|------|---------|-------|-------|--------|
| Bubble Sort | O(n) | O(n²) | O(n²) | O(1) | Yes |
| Insertion Sort | O(n) | O(n²) | O(n²) | O(1) | Yes |
| Merge Sort | O(n log n) | O(n log n) | O(n log n) | O(n) | Yes |
| Quick Sort | O(n log n) | O(n log n) | O(n²) | O(log n) | No |
| Heap Sort | O(n log n) | O(n log n) | O(n log n) | O(1) | No |
| Counting Sort | O(n + k) | O(n + k) | O(n + k) | O(k) | Yes |

### Lower Bound for Comparison Sorting

**Theorem**: Any comparison-based sorting algorithm requires Ω(n log n) comparisons in the worst case.

**Proof sketch:**
- n! possible orderings of n elements
- Each comparison gives 1 bit of information
- Need log₂(n!) ≈ n log n bits to distinguish all orderings

> 任何基于比较的排序算法都需要至少Ω(n log n)次比较。这是信息论的下界。

---

## 📖 3.7 Complexity of Problems (问题的复杂度)

### Problem vs Algorithm Complexity

- **Algorithm complexity**: Time/space for a specific algorithm
- **Problem complexity**: Best possible algorithm for the problem

```
Problem: SORTING
- Naive algorithms: O(n²)
- Merge sort: O(n log n)
- Lower bound: Ω(n log n)
- Problem complexity: Θ(n log n) for comparison-based

Problem: INDEPENDENT SET
- Naive algorithm: O(2^n × n²)
- Best known: O(1.1996^n) [Robson]
- No polynomial algorithm known
- NP-complete → probably no O(n^k) algorithm
```

### Tractable vs Intractable (可处理 vs 不可处理)

| Class | Examples | Status |
|-------|----------|--------|
| **Tractable** (P) | Sorting, Shortest Path, MST | Polynomial time |
| **Intractable** (NP-hard) | IS, SAT, TSP | Exponential (unless P=NP) |
| **Undecidable** | Halting Problem | No algorithm exists! |

---

## 📝 Summary: Algorithmic Insights

### Key Techniques

1. **Divide and Conquer**: Split → Solve → Combine
2. **Dynamic Programming**: Subproblems + Memoization
3. **Greedy**: Locally optimal choices
4. **Graph Algorithms**: BFS, DFS, Dijkstra

### For Independent Set:

| Graph Type | Complexity | Algorithm |
|------------|------------|-----------|
| General graphs | NP-complete | Exponential algorithms |
| Trees | P (O(n)) | Dynamic programming |
| Bipartite graphs | P | König's theorem |
| Interval graphs | P | Greedy |
| Chordal graphs | P | Perfect elimination order |

> 独立集问题的难度取决于图的结构！在某些特殊图类上可以高效求解。

### The Big Picture

```
Algorithm Design Process:
1. Understand the problem
2. Try simple approaches first
3. Look for structure to exploit
4. Choose appropriate technique
5. Prove correctness
6. Analyze complexity
7. If NP-hard, use approximation/heuristics
```

---

*Previous: [Chapter 2](./Chapter2_The_Basics.md)*

*Next: [Chapter 4 - Search](./Chapter4_Search.md)*
