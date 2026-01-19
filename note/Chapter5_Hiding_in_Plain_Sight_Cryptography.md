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

### 5.4 RSA Cryptosystem

**The most famous public key system**, based on factoring difficulty.

#### Key Generation
1. Choose two large primes p and q
2. Compute n = p × q
3. Compute φ(n) = (p-1)(q-1)
4. Choose e such that gcd(e, φ(n)) = 1
5. Compute d such that ed ≡ 1 (mod φ(n))

**Public Key**: (n, e)
**Private Key**: (n, d)

#### Encryption and Decryption
- **Encrypt**: C = M^e mod n
- **Decrypt**: M = C^d mod n

#### Why It Works
By Euler's theorem: M^(ed) ≡ M^(1 + kφ(n)) ≡ M (mod n)

#### Security
RSA security relies on the **factoring assumption**:
> Given n = p × q where p, q are large primes, finding p and q is computationally infeasible.

**Current Standard**: 2048-bit keys (≈ 617 decimal digits)

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

### Shor's Algorithm: Breaking RSA

**The quantum algorithm that threatens current cryptography!**

| Problem | Classical Best | Shor's Algorithm |
|---------|---------------|------------------|
| Factoring | O(exp(n^(1/3))) | O(n³) |
| Discrete Log | O(exp(n^(1/2))) | O(n³) |

**Impact**: A large-scale quantum computer could break RSA, DSA, ECDSA, and DH!

#### How Shor's Algorithm Works (Simplified)

1. **Quantum Period Finding**: Uses quantum Fourier transform to find the period of f(x) = a^x mod N

2. **Classical Reduction**: Convert period to factors using:
   - If r is the period of a^x mod N
   - Then gcd(a^(r/2) ± 1, N) likely gives factors

#### Timeline Concern
- Current estimate: ~10-20 years until cryptographically relevant quantum computers
- **"Harvest now, decrypt later"**: Adversaries may store encrypted data to decrypt later

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

