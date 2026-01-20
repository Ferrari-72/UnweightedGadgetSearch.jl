# Chapter 5: Hiding in Plain Sight - Cryptography

## 📚 Overview

This chapter explores **cryptography** - the science of secure communication. Cryptography is deeply connected to computational complexity and is one of the most impactful applications of quantum computing. Understanding classical cryptography is essential for appreciating both its strengths and vulnerabilities.

---

## 🔑 Key Vocabulary (科研英语词汇)

| English Term | Pronunciation | Chinese | Definition |
|-------------|---------------|---------|------------|
| **Encryption** | /ɪnˈkrɪpʃən/ | 加密 | Converting plaintext to ciphertext |
| **Decryption** | /diːˈkrɪpʃən/ | 解密 | Converting ciphertext back to plaintext |
| **Plaintext** | /ˈpleɪntekst/ | 明文 | The original readable message |
| **Ciphertext** | /ˈsaɪfətekst/ | 密文 | The encrypted, unreadable message |
| **Key** | /kiː/ | 密钥 | Secret information used for encryption/decryption |
| **Symmetric** | /sɪˈmetrɪk/ | 对称的 | Same key for encryption and decryption |
| **Asymmetric** | /ˌeɪsɪˈmetrɪk/ | 非对称的 | Different keys for encryption and decryption |
| **Trapdoor** | /ˈtræpdɔː/ | 陷门 | A function easy to compute but hard to invert without secret info |
| **One-way Function** | /wʌn weɪ ˈfʌŋkʃən/ | 单向函数 | Easy to compute, hard to invert |
| **Factorization** | /ˌfæktəraɪˈzeɪʃən/ | 因式分解 | Breaking a number into prime factors |

---

## 📖 Core Concepts

### 5.1 The Fundamentals of Cryptography

#### The Communication Model

```
Alice  →  Encrypt(message, key)  →  Ciphertext  →  Channel  →  Decrypt(ciphertext, key)  →  Bob
                                                       ↑
                                                     Eve (eavesdropper)
```

#### Security Goals
1. **Confidentiality**: Only authorized parties can read the message
2. **Integrity**: Message hasn't been modified
3. **Authentication**: Verify the sender's identity
4. **Non-repudiation**: Sender cannot deny sending the message

---

### 5.2 Symmetric Key Cryptography

**Idea**: Alice and Bob share a secret key.

#### One-Time Pad (OTP)
The only provably unbreakable cipher!

**Encryption**: C = M ⊕ K (XOR message with key)
**Decryption**: M = C ⊕ K (XOR ciphertext with key)

**Requirements**:
- Key must be truly random
- Key must be as long as the message
- Key must be used only once

**Problem**: Key distribution! Need to securely share a key as long as all messages.

#### Modern Symmetric Ciphers

| Cipher | Key Size | Block Size | Status |
|--------|----------|------------|--------|
| DES | 56 bits | 64 bits | Broken (too small key) |
| 3DES | 168 bits | 64 bits | Legacy, slow |
| AES | 128/192/256 bits | 128 bits | Current standard |

**AES (Advanced Encryption Standard)**:
- Selected by NIST in 2001
- Used worldwide for secure communication
- Quantum resistant with larger keys (AES-256)

---

### 5.3 Public Key Cryptography

**Revolutionary Idea** (Diffie-Hellman, 1976): Use asymmetric keys!

- **Public Key**: Known to everyone (for encryption)
- **Private Key**: Known only to owner (for decryption)

#### The Trapdoor Function Concept

A trapdoor function f has these properties:
1. **Easy to compute**: Given x, compute f(x) easily
2. **Hard to invert**: Given f(x), finding x is hard
3. **Trapdoor**: With secret info, inversion becomes easy

---

### 5.4 RSA Cryptosystem (RSA加密系统)

**The most famous public key system**, based on factoring difficulty.
> RSA是最著名的公钥加密系统，安全性基于大数分解的困难性

#### Key Generation (密钥生成) - Step by Step:

```
步骤1: 选择两个大素数 p 和 q
       例如: p = 61, q = 53
       
步骤2: 计算 n = p × q
       n = 61 × 53 = 3233
       (n 会公开，但 p 和 q 要保密！)
       
步骤3: 计算欧拉函数 φ(n) = (p-1)(q-1)
       φ(3233) = 60 × 52 = 3120
       (这个值也要保密！)
       
步骤4: 选择公钥指数 e，要求 gcd(e, φ(n)) = 1
       常用 e = 65537 (因为二进制只有两个1，计算快)
       这里选 e = 17 (与3120互素)
       
步骤5: 计算私钥指数 d，满足 ed ≡ 1 (mod φ(n))
       17 × d ≡ 1 (mod 3120)
       d = 2753 (因为 17 × 2753 = 46801 = 15 × 3120 + 1)
```

**公钥 Public Key**: (n, e) = (3233, 17) ← 可以公开给任何人！
**私钥 Private Key**: (n, d) = (3233, 2753) ← 必须保密！

#### Encryption and Decryption (加密和解密):

```
加密 (任何人都可以用公钥加密):
   C = M^e mod n
   
   例: 加密消息 M = 123
   C = 123^17 mod 3233 = 855

解密 (只有私钥持有者可以解密):
   M = C^d mod n
   
   例: 解密密文 C = 855
   M = 855^2753 mod 3233 = 123 ✓ 还原了！
```

**图示:**
```
Alice 想发消息给 Bob:

Alice                                    Bob
─────                                    ────
                    ← Bob的公钥(n,e) ←   Bob生成密钥对
                                         公钥: (n, e) 公开
                                         私钥: (n, d) 保密
                                         
用Bob的公钥加密:                          
C = M^e mod n      
       ─── 密文C ───────────────→        用私钥解密:
                                         M = C^d mod n
                                         
即使Eve截获C，没有私钥d也无法解密！
```

#### Why It Works (为什么有效):

> 数学原理：欧拉定理

$$M^{ed} \equiv M^{1 + k\phi(n)} \equiv M \cdot (M^{\phi(n)})^k \equiv M \cdot 1^k \equiv M \pmod{n}$$

简单说：加密后再解密，能还原原始消息！

#### Security (安全性):

RSA的安全性依赖于**大数分解难题**:
> 给定 n = p × q（两个大素数的乘积），找出 p 和 q 是极其困难的

```
为什么分解 n 就能破解？
如果知道 p 和 q:
→ 可以计算 φ(n) = (p-1)(q-1)
→ 可以计算 d（私钥）
→ 可以解密任何消息！

现实中的 n 有多大？
- 2048位 ≈ 617位十进制数
- 分解这样的数，经典计算机需要数十亿年！
```

**Current Standard**: 2048-bit keys (当前标准：2048位密钥)

---

### 5.5 The Factoring Problem

**Problem**: Given N = p × q, find p and q.

#### Best Classical Algorithms

| Algorithm | Time Complexity | Type |
|-----------|-----------------|------|
| Trial Division | O(√N) | Deterministic |
| Pollard's Rho | O(N^(1/4)) | Probabilistic |
| Quadratic Sieve | O(exp(√(log N · log log N))) | Subexponential |
| Number Field Sieve | O(exp(n^(1/3))) | Best known |

**None of these are polynomial time!**

---

### 5.6 Discrete Logarithm Problem

Another foundation for cryptography.

**Problem**: Given g, h, and prime p, find x such that g^x ≡ h (mod p)

#### Diffie-Hellman Key Exchange

```
Public: prime p, generator g

Alice                              Bob
------                             ----
Choose secret a                    Choose secret b
Compute A = g^a mod p              Compute B = g^b mod p
        --------→ A →--------
        ←------- B ←--------
Compute s = B^a mod p              Compute s = A^b mod p
       = g^(ab) mod p                    = g^(ab) mod p
```

Both Alice and Bob now share secret s = g^(ab) mod p, but Eve only sees g^a and g^b!

---

## 🔬 Quantum Cryptography

### Shor's Algorithm: Breaking RSA (Shor算法：破解RSA)

**The quantum algorithm that threatens current cryptography!**
> 这是威胁现有密码学的量子算法！

#### Speed Comparison (速度对比):

| 问题 | 经典最佳算法 | Shor算法 | 加速幅度 |
|------|-------------|----------|----------|
| 大数分解 | O(exp(n^(1/3))) 指数级 | O(n³) 多项式级 | **指数级加速!** |
| 离散对数 | O(exp(n^(1/2))) 指数级 | O(n³) 多项式级 | **指数级加速!** |

**Impact (影响)**: 大规模量子计算机可以破解 RSA, DSA, ECDSA, DH 等所有基于分解和离散对数的加密系统！

#### How Shor's Algorithm Works (Shor算法工作原理):

> 核心思想：把分解问题转化为**周期查找**问题，而量子计算机擅长找周期！

```
步骤 1: 把分解转化为周期问题
────────────────────────────────
要分解 N = 15
选择随机数 a = 7（与N互素）

考虑函数: f(x) = 7^x mod 15

x:    0  1  2   3   4  5  6   7   8  ...
f(x): 1  7  4  13   1  7  4  13   1  ...
              ↑               ↑
              周期 r = 4！
              
步骤 2: 量子傅里叶变换找周期
────────────────────────────────
经典计算机找周期: 可能需要试很多 x 值
量子计算机: 用量子傅里叶变换，多项式时间搞定！

步骤 3: 从周期得到因子
────────────────────────────────
已知 r = 4

计算:
- a^(r/2) + 1 = 7^2 + 1 = 50
- a^(r/2) - 1 = 7^2 - 1 = 48

求最大公因数:
- gcd(50, 15) = 5  ← 一个因子！
- gcd(48, 15) = 3  ← 另一个因子！

验证: 5 × 3 = 15 ✓
```

**为什么量子计算机能快速找周期？**
```
量子叠加 + 量子傅里叶变换
    ↓
同时"检查"所有可能的周期
    ↓
测量后得到正确周期
```

#### Timeline Concern (时间线担忧):

```
现在 ─────────────────────────────→ 未来(10-20年?)
  │                                      │
  │ 量子计算机还太小                      │ 大规模量子计算机
  │ (几百个量子比特)                      │ (需要数百万量子比特)
  │                                      │
  ↓                                      ↓
目前RSA安全                            RSA可能被破解！
```

**"Harvest now, decrypt later" (现在收集，以后解密)**:
> ⚠️ 对手可能现在就在收集加密数据，等量子计算机成熟后再解密！
> 
> 这对需要长期保密的数据（政府机密、医疗记录等）是个严重威胁！

### Post-Quantum Cryptography

Cryptosystems believed to be quantum-resistant:

| Type | Examples | Based On |
|------|----------|----------|
| **Lattice-based** | NTRU, Kyber, Dilithium | Shortest vector problem |
| **Code-based** | McEliece | Error-correcting codes |
| **Hash-based** | SPHINCS+ | Hash function security |
| **Multivariate** | Rainbow | Solving polynomial systems |
| **Isogeny-based** | SIKE (broken 2022!) | Elliptic curve isogenies |

**NIST Post-Quantum Standards (2024)**:
- CRYSTALS-Kyber (key encapsulation)
- CRYSTALS-Dilithium (digital signatures)
- SPHINCS+ (hash-based signatures)

### Quantum Key Distribution (QKD)

**Use quantum mechanics for provably secure key distribution!**

#### BB84 Protocol
1. Alice sends qubits in random bases (+ or ×)
2. Bob measures in random bases
3. They publicly compare bases (not results!)
4. Keep only matching-basis measurements
5. Any eavesdropping disturbs the quantum states → detected!

**Advantage**: Security based on physics, not computational assumptions
**Limitation**: Requires quantum channel, limited distance

---

## 📝 Practice Exercises

### Exercise 1: RSA Calculation
Given p = 5, q = 11, e = 3:
1. Calculate n and φ(n)
2. Find d (the private exponent)
3. Encrypt M = 7

<details>
<summary>Answer</summary>

1. n = 5 × 11 = 55, φ(n) = 4 × 10 = 40
2. d such that 3d ≡ 1 (mod 40), so d = 27 (since 3 × 27 = 81 = 2×40 + 1)
3. C = 7³ mod 55 = 343 mod 55 = 13

</details>

### Exercise 2: Security Analysis
Why can't we just use a 10,000-bit RSA key to be "quantum-safe"?

<details>
<summary>Answer</summary>

Shor's algorithm has polynomial complexity O(n³), so:
- Doubling key size only increases quantum attack time by factor of 8
- A 10,000-bit key would take ~1000× longer than 2048-bit, but still polynomial
- For true security, we need fundamentally different mathematical problems (post-quantum crypto)

</details>

### Exercise 3: Research Writing
Improve this sentence:

*"Quantum computers will break all encryption."*

<details>
<summary>Suggested Answer</summary>

*"Large-scale fault-tolerant quantum computers, if realized, would compromise the security of widely-deployed public-key cryptosystems based on integer factorization and discrete logarithms, necessitating a transition to post-quantum cryptographic algorithms."*

</details>

---

## 📚 Key Takeaways

1. **Symmetric encryption** is fast but requires pre-shared keys
2. **Public key cryptography** solves key distribution using trapdoor functions
3. **RSA** relies on the difficulty of factoring large numbers
4. **Shor's algorithm** provides exponential quantum speedup for factoring
5. **Post-quantum cryptography** is being standardized to prepare for quantum threats
6. **QKD** offers information-theoretic security but has practical limitations

---

## 🔗 Cryptographic Complexity Summary

| Problem | Classical | Quantum | Broken by Quantum? |
|---------|-----------|---------|-------------------|
| AES-256 | Secure | Grover: √ speedup | No (use larger keys) |
| RSA-2048 | Secure | Shor: polynomial | **Yes** |
| ECDSA-256 | Secure | Shor: polynomial | **Yes** |
| Lattice (Kyber) | Secure | No known attack | No |
| Hash functions | Secure | Grover: √ speedup | No (double output) |

---

*Previous: [Chapter 4 - Needles in Haystacks](./Chapter4_Needles_in_Haystacks_Search.md)*

*Next: [Chapter 6 - Computers and Complexity](./Chapter6_Computers_and_Complexity.md)*

