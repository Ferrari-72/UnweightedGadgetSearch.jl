# Chapter 2: The Basics - Logic, Sets, and Functions

## 📚 Overview

This chapter covers the **mathematical foundations** essential for understanding computation theory. These concepts form the language we use to describe algorithms, proofs, and computational problems.

---

## 🔑 Key Vocabulary (科研英语词汇)

| English Term | Pronunciation | Chinese | Definition |
|-------------|---------------|---------|------------|
| **Proposition** | /ˌprɒpəˈzɪʃən/ | 命题 | A statement that is either true or false |
| **Predicate** | /ˈpredɪkət/ | 谓词 | A statement containing variables that becomes a proposition when values are assigned |
| **Quantifier** | /ˈkwɒntɪfaɪər/ | 量词 | Symbols ∀ (for all) and ∃ (there exists) that specify the scope of variables |
| **Conjunction** | /kənˈdʒʌŋkʃən/ | 合取/与 | Logical AND (∧) - true only when both operands are true |
| **Disjunction** | /dɪsˈdʒʌŋkʃən/ | 析取/或 | Logical OR (∨) - true when at least one operand is true |
| **Negation** | /nɪˈɡeɪʃən/ | 否定 | Logical NOT (¬) - reverses the truth value |
| **Implication** | /ˌɪmplɪˈkeɪʃən/ | 蕴含 | "If...then" statement (→), false only when premise is true and conclusion is false |
| **Bijection** | /baɪˈdʒekʃən/ | 双射 | A function that is both injective (one-to-one) and surjective (onto) |
| **Cardinality** | /ˌkɑːdɪˈnælɪti/ | 基数 | The number of elements in a set |
| **Countable** | /ˈkaʊntəbəl/ | 可数的 | A set that can be put in one-to-one correspondence with natural numbers |

---

## 📖 Core Concepts

### 2.1 Propositional Logic (命题逻辑)

Propositional logic deals with **propositions** - statements that are either TRUE or FALSE.

#### Basic Logical Connectives

| Symbol | Name | English | Example |
|--------|------|---------|---------|
| ∧ | Conjunction | AND | P ∧ Q (P and Q) |
| ∨ | Disjunction | OR | P ∨ Q (P or Q) |
| ¬ | Negation | NOT | ¬P (not P) |
| → | Implication | IF...THEN | P → Q (if P then Q) |
| ↔ | Biconditional | IF AND ONLY IF | P ↔ Q (P iff Q) |

#### Truth Tables

**Implication (→)** - This is crucial and often confusing!

| P | Q | P → Q |
|---|---|-------|
| T | T | **T** |
| T | F | **F** |
| F | T | **T** |
| F | F | **T** |

> **Key Insight**: "False implies anything" - A false premise makes any implication true.

#### Research Phrase Examples:
- *"We prove this theorem by showing that the negation leads to a contradiction."*
- *"The implication P → Q can be rewritten as ¬P ∨ Q."*

---

### 2.2 Predicate Logic (谓词逻辑)

Predicate logic extends propositional logic with **variables** and **quantifiers**.

#### Quantifiers

| Symbol | Name | English | Meaning |
|--------|------|---------|---------|
| ∀ | Universal | For all | "Every element satisfies..." |
| ∃ | Existential | There exists | "At least one element satisfies..." |

#### Examples:
- ∀x P(x) means "For all x, P(x) is true"
- ∃x P(x) means "There exists some x such that P(x) is true"

#### Important Equivalences:
$$¬(∀x P(x)) ≡ ∃x ¬P(x)$$
$$¬(∃x P(x)) ≡ ∀x ¬P(x)$$

> **In English**: "Not all x have property P" is the same as "Some x doesn't have property P"

---

### 2.3 Set Theory Basics (集合论基础)

#### Set Notation

| Symbol | Meaning | Example |
|--------|---------|---------|
| ∈ | Element of | x ∈ A (x is in A) |
| ∉ | Not element of | x ∉ A (x is not in A) |
| ⊆ | Subset | A ⊆ B (A is subset of B) |
| ⊂ | Proper subset | A ⊂ B (A is proper subset of B) |
| ∪ | Union | A ∪ B (elements in A or B) |
| ∩ | Intersection | A ∩ B (elements in both A and B) |
| \ | Set difference | A \ B (elements in A but not B) |
| ∅ | Empty set | The set with no elements |

#### Important Sets in Computer Science:
- **ℕ** = Natural numbers {0, 1, 2, 3, ...}
- **ℤ** = Integers {..., -2, -1, 0, 1, 2, ...}
- **ℚ** = Rational numbers
- **ℝ** = Real numbers
- **{0,1}*** = Set of all binary strings (crucial for computation!)

---

### 2.4 Functions (函数)

A **function** f: A → B maps each element of A to exactly one element of B.

#### Types of Functions

| Type | Definition | Example |
|------|------------|---------|
| **Injective** (one-to-one) | Different inputs → different outputs | f(x) = 2x |
| **Surjective** (onto) | Every output is reached | f: ℤ → ℕ, f(x) = |x| is NOT surjective |
| **Bijective** | Both injective and surjective | f(x) = x + 1 on ℤ |

#### Why Bijections Matter:
- Two sets have the **same cardinality** if there exists a bijection between them
- This is how we compare sizes of infinite sets!

---

### 2.5 Countability and Infinity (可数性与无穷)

#### Countable Sets
A set is **countable** if its elements can be listed: a₁, a₂, a₃, ...

**Surprising Result**: ℚ (rationals) is countable!

We can enumerate all rationals using **Cantor's diagonal argument**:

```
1/1  1/2  1/3  1/4  ...
2/1  2/2  2/3  2/4  ...
3/1  3/2  3/3  3/4  ...
...
```

Follow the diagonals: 1/1, 1/2, 2/1, 3/1, 2/2, 1/3, 1/4, ...

#### Uncountable Sets
**Cantor's Theorem**: ℝ (real numbers) is **uncountable**.

**Proof Sketch** (Diagonalization):
1. Assume we can list all reals between 0 and 1
2. Construct a new number by changing each diagonal digit
3. This number differs from every listed number
4. Contradiction! ∎

> **Key Insight for Quantum Computing**: The set of quantum states is uncountable (continuous), but we can only prepare and measure a finite number of states.

---

## 🔬 Connection to Quantum Computing

### Boolean Functions and Quantum Gates

Classical computation uses **Boolean functions**: f: {0,1}ⁿ → {0,1}ᵐ

Quantum computation uses **unitary matrices**: U: ℂ²ⁿ → ℂ²ⁿ

| Classical | Quantum |
|-----------|---------|
| AND, OR, NOT gates | Hadamard, CNOT, T gates |
| Reversible: XOR | All quantum gates are reversible |
| Deterministic | Probabilistic outcomes |

### Important Quantum-Classical Connection:
Any classical reversible circuit can be implemented as a quantum circuit!

---

## 📝 Practice Exercises

### Exercise 1: Logic Translation
Translate into logical notation:

1. "All prime numbers greater than 2 are odd"
2. "There exists a quantum algorithm faster than any classical algorithm for this problem"

<details>
<summary>Answers</summary>

1. ∀n ((prime(n) ∧ n > 2) → odd(n))
2. ∃Q (quantum_algorithm(Q) ∧ ∀C (classical_algorithm(C) → faster(Q, C)))

</details>

### Exercise 2: Set Operations
Given A = {1, 2, 3, 4} and B = {3, 4, 5, 6}, find:

1. A ∪ B = ?
2. A ∩ B = ?
3. A \ B = ?
4. |A × B| = ?

<details>
<summary>Answers</summary>

1. A ∪ B = {1, 2, 3, 4, 5, 6}
2. A ∩ B = {3, 4}
3. A \ B = {1, 2}
4. |A × B| = 4 × 4 = 16

</details>

### Exercise 3: Research Writing
Improve this sentence:

*"We look at all the elements in the set."*

<details>
<summary>Suggested Answer</summary>

*"We enumerate all elements in the set S"* or *"We consider each element s ∈ S."*

</details>

---

## 📚 Key Takeaways

1. **Propositional logic** provides the foundation for Boolean circuits and SAT problems
2. **Predicate logic** allows us to make statements about infinite domains
3. **Set theory** gives us the language to describe computational problems
4. **Functions** formalize the concept of computation
5. **Countability** distinguishes fundamentally different sizes of infinity

---

## 🔗 Common Proof Techniques

| Technique | When to Use | Structure |
|-----------|-------------|-----------|
| **Direct Proof** | Prove P → Q directly | Assume P, derive Q |
| **Contrapositive** | When direct proof is hard | Prove ¬Q → ¬P instead |
| **Contradiction** | Prove something exists/doesn't exist | Assume ¬P, derive contradiction |
| **Induction** | Statements about natural numbers | Base case + inductive step |
| **Diagonalization** | Prove uncountability | Construct element not in list |

---

*Previous: [Chapter 1 - Prologue](./Chapter1_Prologue_The_Ladder_of_Causation.md)*

*Next Chapter: [Chapter 3 - Insights and Algorithms](./Chapter3_Insights_and_Algorithms.md)*

