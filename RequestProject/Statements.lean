/-
  Statements.lean
  ===============
  Auditable statement file for the Selberg Majorant Improvement project.

  ── HOW TO USE ──────────────────────────────────────────────────────────────
  This file has ONE import: `import Mathlib`.
  No `RequestProject.*` imports appear anywhere.

  Every theorem is stated purely in Mathlib primitives, with `sorry` as the
  proof body. The file compiles cleanly against Mathlib alone, so a reviewer
  can verify that every statement is well-typed without building the project.

  To check: `lake build RequestProject.Statements`
  Expected: zero errors; only `declaration uses sorry` warnings (intended).

  ── CONTENTS ────────────────────────────────────────────────────────────────
  §1.  Theorem 1: Mass, L² improvement, quadratic form identity   (4 theorems)
  §2.  Theorem 2: Restriction lower bound and additive energy      (6 theorems)
  §3.  Selberg upper bound infrastructure                          (2 theorems)
  §4.  Theorem 3: Kinetic propagation                              (3 theorems)
  §5.  Theorem 4: Quadratic form stability                         (5 theorems)

  Total: 20 theorems, matching Audit.lean exactly.
  Axiom footprint for each: [propext, Classical.choice, Quot.sound].
  ────────────────────────────────────────────────────────────────────────────
-/
import Mathlib

open Finset BigOperators Real Complex

noncomputable section

-- ════════════════════════════════════════════════════════════════════════════
-- §1.  Theorem 1: Mass, L² improvement, quadratic form identity
-- ════════════════════════════════════════════════════════════════════════════

/-- **[1.1] Mass improvement.**
    The Selberg majorant ν(x) = 1 if d∤x, 1/2 if d∣x has strictly smaller
    ℓ¹ mass than the constant-1 baseline:  ∑ ν < d·m. -/
theorem selbergComparison_massImprovement
    (d m : ℕ) (hd : 2 ≤ d) (hm : 1 ≤ m) :
    let ν : Fin (d * m) → ℝ := fun x => if d ∣ x.val then 1/2 else 1
    ∑ x : Fin (d * m), ν x < (d * m : ℝ) := by
  sorry

/-- **[1.2] L² improvement.**
    The Selberg majorant has strictly smaller ℓ² norm squared than the
    constant-1 baseline:  ∑ ν² < d·m. -/
theorem sieveMajorant_l2_improvement
    (d m : ℕ) (hd : 2 ≤ d) (hm : 1 ≤ m) :
    let ν : Fin (d * m) → ℝ := fun x => if d ∣ x.val then 1/2 else 1
    ∑ x : Fin (d * m), ν x ^ 2 < (d * m : ℝ) := by
  sorry

/-- **[1.3] Quadratic form identity.**
    The ℓ² norm of the Selberg majorant, normalized by N = d·m, equals the
    Selberg quadratic form Q(λ) at λ₁ = 1, λ_d = −1/2:
      (∑ ν²) / (d·m) = 1 − 3/(4d). -/
theorem sieveMajorant_l2NormSq_eq_selbergForm
    (d m : ℕ) (hd : 2 ≤ d) (hm : 1 ≤ m) :
    let ν : Fin (d * m) → ℝ := fun x => if d ∣ x.val then 1/2 else 1
    (∑ x : Fin (d * m), ν x ^ 2) / (d * m) = 1 - 3 / (4 * (d : ℝ)) := by
  sorry

/-- **[1.4] Dual improvement.**
    The Selberg majorant simultaneously achieves both strict mass improvement
    and strict L² improvement over the constant-1 baseline. -/
theorem selbergComparison_dual_improvement
    (d m : ℕ) (hd : 2 ≤ d) (hm : 1 ≤ m) :
    let ν : Fin (d * m) → ℝ := fun x => if d ∣ x.val then 1/2 else 1
    (∑ x : Fin (d * m), ν x < (d * m : ℝ)) ∧
    (∑ x : Fin (d * m), ν x ^ 2 < (d * m : ℝ)) := by
  sorry

-- ════════════════════════════════════════════════════════════════════════════
-- §2.  Theorem 2: Restriction lower bound and additive energy
-- ════════════════════════════════════════════════════════════════════════════

/-- **[2.1] Abstract restriction lower bound.**
    Any nonneg majorant ν dominating an indicator f on Fin N satisfies:
      mass(ν)² · ‖ν‖₂² ≥ |S|⁴ / N.
    Proved from Cauchy–Schwarz and pointwise domination alone. -/
theorem restriction_lower_bound
    {N : ℕ} (ν f : Fin N → ℝ)
    (hν   : ∀ x, 0 ≤ ν x)
    (hf   : ∀ x, f x = 0 ∨ f x = 1)
    (hdom : ∀ x, f x ≤ ν x)
    (hN   : (0 : ℝ) < N) :
    (∑ x : Fin N, ν x) ^ 2 * (∑ x : Fin N, ν x ^ 2) ≥
      (∑ x : Fin N, f x) ^ 4 / N := by
  sorry

/-- **[2.2] Sieve additive energy lower bound (abstract).**
    For any nonneg majorant ν dominating indicator f on Fin N:
      E(ν) ≥ |S|⁴ / N³. -/
theorem sieve_additive_energy_lower
    {N : ℕ} [NeZero N] (ν f : Fin N → ℝ)
    (hν   : ∀ x, 0 ≤ ν x)
    (hf   : ∀ x, f x = 0 ∨ f x = 1)
    (hdom : ∀ x, f x ≤ ν x)
    (hN   : (0 : ℝ) < N) :
    (∑ x : Fin N, (∑ a : Fin N, ν a * ν (x - a)) ^ 2) ≥
      (∑ x : Fin N, f x) ^ 4 / N ^ 3 := by
  sorry

/-- **[2.3] Zero-mode Fourier restatement of the restriction lower bound.**
    The same bound as [2.1], restated in terms of the DFT energy via Parseval.
    This is a restatement of the spatial Cauchy–Schwarz proof, not an
    independent Fourier argument: ν̂(0) = mass and Parseval gives
    ∑ |ν̂(k)|² = N · ∑ ν(x)², recovering the same inequality. -/
theorem restriction_lower_bound_zero_mode
    {N : ℕ} [NeZero N] (ν f : Fin N → ℝ)
    (hν   : ∀ x, 0 ≤ ν x)
    (hf   : ∀ x, f x = 0 ∨ f x = 1)
    (hdom : ∀ x, f x ≤ ν x)
    (hN   : (0 : ℝ) < N) :
    let νc  : Fin N → ℂ := fun x => (ν x : ℂ)
    let dft : Fin N → ℂ := fun k =>
      ∑ n : Fin N, νc n * Complex.exp (-2 * π * Complex.I * k.val * n.val / N)
    (∑ x : Fin N, f x) ^ 4 ≤
      N * (∑ x : Fin N, ν x) ^ 2 *
      ((∑ k : Fin N, ‖dft k‖ ^ 2) / N) := by
  sorry

/-- **[2.4] Selberg concrete restriction bound.**
    For the Selberg majorant on Fin(d·m):
      mass(ν)² · ‖ν‖₂² ≥ (d·m − m)⁴ / (d·m). -/
theorem selberg_concrete_restriction_bound
    (d m : ℕ) (hd : 2 ≤ d) (hm : 1 ≤ m) :
    let ν : Fin (d * m) → ℝ := fun x => if d ∣ x.val then 1/2 else 1
    (∑ x : Fin (d * m), ν x) ^ 2 * (∑ x : Fin (d * m), ν x ^ 2) ≥
      ((d * m - m : ℕ) : ℝ) ^ 4 / (d * m) := by
  sorry

/-- **[2.5] Selberg majorant: explicit additive energy lower bound.**
    E(ν) ≥ (d·m − m)⁴ / (d·m)³. -/
theorem selberg_additive_energy_explicit
    (d m : ℕ) (hd : 2 ≤ d) (hm : 1 ≤ m) :
    let ν : Fin (d * m) → ℝ := fun x => if d ∣ x.val then 1/2 else 1
    (∑ x : Fin (d * m), (∑ a : Fin (d * m), ν a * ν (x - a)) ^ 2) ≥
      ((d * m - m : ℕ) : ℝ) ^ 4 / (d * m) ^ 3 := by
  sorry

/-- **[2.6] Mass-energy interval.**
    The Selberg majorant satisfies both bounds simultaneously:
      (d·m − m)⁴ / (d·m) ≤ mass(ν)² · ‖ν‖₂² < (d·m)³. -/
theorem selberg_mass_energy_interval
    (d m : ℕ) (hd : 2 ≤ d) (hm : 1 ≤ m) :
    let ν : Fin (d * m) → ℝ := fun x => if d ∣ x.val then 1/2 else 1
    ((d * m - m : ℕ) : ℝ) ^ 4 / (d * m) ≤
      (∑ x : Fin (d * m), ν x) ^ 2 * (∑ x : Fin (d * m), ν x ^ 2) ∧
    (∑ x : Fin (d * m), ν x) ^ 2 * (∑ x : Fin (d * m), ν x ^ 2) <
      ((d * m : ℕ) : ℝ) ^ 3 := by
  sorry

-- ════════════════════════════════════════════════════════════════════════════
-- §3.  Selberg upper bound infrastructure
-- ════════════════════════════════════════════════════════════════════════════

/-- **[3.1] Selberg upper bound.**
    For any A : Finset ℕ, P : ℕ, lam : ℕ → ℝ, D : Finset ℕ with 1 ∈ D and
    lam 1 = 1, the sieve weight w(n) = ∑_{d ∈ D, d ∣ gcd(n,P)} lam d satisfies
    w(n) = 1 for all n coprime to P, giving:
      |{n ∈ A | gcd(n,P) = 1}| ≤ ∑_{n ∈ A} w(n)². -/
theorem siftedSet_card_le_quadraticSum
    (A : Finset ℕ) (P : ℕ) (lam : ℕ → ℝ) (D : Finset ℕ)
    (hlambda_one : lam 1 = 1)
    (hD          : 1 ∈ D) :
    ((A.filter (fun n => Nat.Coprime n P)).card : ℝ) ≤
      ∑ n ∈ A, (∑ d ∈ D.filter (· ∣ Nat.gcd n P), lam d) ^ 2 := by
  sorry

/-- **[3.2] Weighted remainder bound.**
    ∑_{d ∈ D} lam(d) · R(d) ≤ ∑_{d ∈ D} |lam(d)| · |R(d)|. -/
theorem weighted_remainder_bound
    (lam R : ℕ → ℝ) (D : Finset ℕ) :
    ∑ d ∈ D, lam d * R d ≤ ∑ d ∈ D, |lam d| * |R d| := by
  sorry

-- ════════════════════════════════════════════════════════════════════════════
-- §4.  Theorem 3: Kinetic propagation
-- ════════════════════════════════════════════════════════════════════════════

/-- **[4.1] Kinetic Propagation Theorem.**
    If f, g : ℕ → ℝ are multiplicative on squarefree coprime pairs,
    f(1) = g(1) = 1, |f(p) − g(p)| ≤ ε, and |f(p)|, |g(p)| ≤ M for all
    sieving primes p ≤ z, then for every squarefree d with all prime factors
    among those sieving primes:
      |f(d) − g(d)| ≤ ε · ω(d) · M^(ω(d)−1). -/
theorem perturbation_propagates
    (f g : ℕ → ℝ)
    (hf1 : f 1 = 1) (hg1 : g 1 = 1)
    (hf_mult : ∀ d e : ℕ, Squarefree d → Squarefree e → Nat.Coprime d e →
                 f (d * e) = f d * f e)
    (hg_mult : ∀ d e : ℕ, Squarefree d → Squarefree e → Nat.Coprime d e →
                 g (d * e) = g d * g e)
    (ε M : ℝ) (hε : 0 ≤ ε) (hM : 0 ≤ M)
    (sievingPrime : ℕ → Prop) (z : ℕ)
    (hε_primes : ∀ p : ℕ, p.Prime → sievingPrime p → p ≤ z → |f p - g p| ≤ ε)
    (hfM : ∀ p : ℕ, p.Prime → sievingPrime p → p ≤ z → |f p| ≤ M)
    (hgM : ∀ p : ℕ, p.Prime → sievingPrime p → p ≤ z → |g p| ≤ M)
    (d : ℕ) (hd : Squarefree d)
    (hd_primes : ∀ p ∈ d.primeFactors, p.Prime ∧ sievingPrime p ∧ p ≤ z) :
    |f d - g d| ≤ ε * d.primeFactors.card * M ^ (d.primeFactors.card - 1) := by
  sorry

/-- **[4.2] Euler product stability.**
    The partial reciprocal sums ∑_{d ∈ D} 1/f(d) and ∑_{d ∈ D} 1/g(d) are
    close under the kinetic propagation bound:
      |∑ 1/f(d) − ∑ 1/g(d)| ≤ ∑_{d ∈ D} ε·ω(d)·M^(ω(d)−1) / (f(d)·g(d)). -/
theorem eulerProduct_stability
    (f g : ℕ → ℝ)
    (hf_mult : ∀ d e : ℕ, Squarefree d → Squarefree e → Nat.Coprime d e →
                 f (d * e) = f d * f e)
    (hg_mult : ∀ d e : ℕ, Squarefree d → Squarefree e → Nat.Coprime d e →
                 g (d * e) = g d * g e)
    (hf1 : f 1 = 1) (hg1 : g 1 = 1)
    (ε M : ℝ) (hε : 0 ≤ ε) (hM : 0 ≤ M)
    (sievingPrime : ℕ → Prop) (z : ℕ)
    (hε_primes : ∀ p : ℕ, p.Prime → sievingPrime p → p ≤ z → |f p - g p| ≤ ε)
    (hfM : ∀ p : ℕ, p.Prime → sievingPrime p → p ≤ z → |f p| ≤ M)
    (hgM : ∀ p : ℕ, p.Prime → sievingPrime p → p ≤ z → |g p| ≤ M)
    (D : Finset ℕ)
    (hD        : ∀ d ∈ D, Squarefree d)
    (hD_primes : ∀ d ∈ D, ∀ p ∈ d.primeFactors, p.Prime ∧ sievingPrime p ∧ p ≤ z)
    (hf_pos    : ∀ d ∈ D, 0 < f d)
    (hg_pos    : ∀ d ∈ D, 0 < g d) :
    |∑ d ∈ D, 1 / f d - ∑ d ∈ D, 1 / g d| ≤
      ∑ d ∈ D, ε * d.primeFactors.card * M ^ (d.primeFactors.card - 1) /
               (f d * g d) := by
  sorry

/-- **[4.3] H-functional stability.**
    The arithmetic H-functional H(f) = ∑_{d ∈ D} (f(d)/d) · log(f(d)/d)
    is stable under perturbation of the density at primes. -/
theorem sieveH_stable
    (f g : ℕ → ℝ)
    (hf_mult : ∀ d e : ℕ, Squarefree d → Squarefree e → Nat.Coprime d e →
                 f (d * e) = f d * f e)
    (hg_mult : ∀ d e : ℕ, Squarefree d → Squarefree e → Nat.Coprime d e →
                 g (d * e) = g d * g e)
    (hf1 : f 1 = 1) (hg1 : g 1 = 1)
    (ε M : ℝ) (hε : 0 ≤ ε) (hM : 0 < M)
    (sievingPrime : ℕ → Prop) (z : ℕ)
    (hε_primes : ∀ p : ℕ, p.Prime → sievingPrime p → p ≤ z → |f p - g p| ≤ ε)
    (hfM : ∀ p : ℕ, p.Prime → sievingPrime p → p ≤ z → |f p| ≤ M)
    (hgM : ∀ p : ℕ, p.Prime → sievingPrime p → p ≤ z → |g p| ≤ M)
    (D : Finset ℕ)
    (hD        : ∀ d ∈ D, Squarefree d)
    (hD_primes : ∀ d ∈ D, ∀ p ∈ d.primeFactors, p.Prime ∧ sievingPrime p ∧ p ≤ z)
    (hf_pos    : ∀ d ∈ D, 0 < f d)
    (hg_pos    : ∀ d ∈ D, 0 < g d) :
    |∑ d ∈ D, (f d / d) * Real.log (f d / d) -
     ∑ d ∈ D, (g d / d) * Real.log (g d / d)| ≤
      ε * ∑ d ∈ D,
        (1 + |Real.log (f d / d)| + |Real.log (g d / d)|) *
        (d.primeFactors.card * M ^ (d.primeFactors.card - 1) / (d : ℝ)) := by
  sorry

-- ════════════════════════════════════════════════════════════════════════════
-- §5.  Theorem 4: Quadratic form stability
-- ════════════════════════════════════════════════════════════════════════════

/-- **[5.1] Nat.Squarefree.lcm.**
    If d and e are squarefree then Nat.lcm d e is squarefree.
    Absent from Mathlib as of v4.28.0; proved in this project. -/
theorem Nat.Squarefree.lcm
    {d e : ℕ} (hd : Squarefree d) (he : Squarefree e) :
    Squarefree (Nat.lcm d e) := by
  sorry

/-- **[5.2] Inverse difference bound.**
    |1/f(d) − 1/g(d)| ≤ |f(d) − g(d)| / (f(d) · g(d)). -/
theorem inv_diff_bound
    {f g : ℕ → ℝ} {d : ℕ}
    (hf : 0 < f d) (hg : 0 < g d) :
    |1 / f d - 1 / g d| ≤ |f d - g d| / (f d * g d) := by
  sorry

/-- **[5.3] Quadratic form term difference.**
    |lam(d)·lam(e)/f(lcm) − lam(d)·lam(e)/g(lcm)| ≤
      |lam(d)|·|lam(e)|·|f(lcm)−g(lcm)| / (f(lcm)·g(lcm)). -/
theorem quadForm_term_diff
    (lam f g : ℕ → ℝ) (d e : ℕ)
    (hf : 0 < f (Nat.lcm d e)) (hg : 0 < g (Nat.lcm d e)) :
    |lam d * lam e / f (Nat.lcm d e) - lam d * lam e / g (Nat.lcm d e)| ≤
      |lam d| * |lam e| * |f (Nat.lcm d e) - g (Nat.lcm d e)| /
      (f (Nat.lcm d e) * g (Nat.lcm d e)) := by
  sorry

/-- **[5.4] Quadratic form term bound.**
    Applies the kinetic propagation bound to control the per-term difference
    in the Selberg quadratic form. -/
theorem quadForm_term_bound
    (lam f g : ℕ → ℝ) (ε M : ℝ)
    (hkin : ∀ n, Squarefree n →
        |f n - g n| ≤ ε * n.primeFactors.card * M ^ (n.primeFactors.card - 1))
    (d e : ℕ)
    (hf : 0 < f (Nat.lcm d e)) (hg : 0 < g (Nat.lcm d e))
    (hlcm_sq : Squarefree (Nat.lcm d e)) :
    |lam d * lam e / f (Nat.lcm d e) - lam d * lam e / g (Nat.lcm d e)| ≤
      |lam d| * |lam e| * ε * (Nat.lcm d e).primeFactors.card *
      M ^ ((Nat.lcm d e).primeFactors.card - 1) /
      (f (Nat.lcm d e) * g (Nat.lcm d e)) := by
  sorry

/-- **[5.5] Selberg quadratic form stability.**
    The Selberg quadratic form Q(lam, f) = ∑_{d,e} lam(d)·lam(e)/f(lcm(d,e))
    is Lipschitz in f under the kinetic propagation bound:
      |Q(lam,f) − Q(lam,g)| ≤ ε · ∑_{d,e ≤ D} explicit bound. -/
theorem quadForm_kinetic_stability
    (D : ℕ) (lam f g : ℕ → ℝ)
    (hlambda_one     : lam 1 = 1)
    (hlambda_support : ∀ d, D < d → lam d = 0)
    (hlambda_sqfree  : ∀ d, ¬Squarefree d → lam d = 0)
    (hf_pos : ∀ d, 0 < d → Squarefree d → 0 < f d)
    (hg_pos : ∀ d, 0 < d → Squarefree d → 0 < g d)
    (ε M : ℝ) (hε : 0 ≤ ε) (hM : 0 ≤ M)
    (hkin : ∀ d, Squarefree d →
        |f d - g d| ≤ ε * d.primeFactors.card * M ^ (d.primeFactors.card - 1)) :
    |(∑ d ∈ Finset.range (D + 1), ∑ e ∈ Finset.range (D + 1),
        lam d * lam e / f (Nat.lcm d e)) -
     (∑ d ∈ Finset.range (D + 1), ∑ e ∈ Finset.range (D + 1),
        lam d * lam e / g (Nat.lcm d e))| ≤
      ε * ∑ d ∈ Finset.range (D + 1), ∑ e ∈ Finset.range (D + 1),
        |lam d| * |lam e| *
        (Nat.lcm d e).primeFactors.card *
        M ^ ((Nat.lcm d e).primeFactors.card - 1) /
        (f (Nat.lcm d e) * g (Nat.lcm d e)) := by
  sorry

end
