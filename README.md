# Selberg Majorant Improvement: A Lean 4 Formalization

Machine-verified proofs of four independent results about a single-prime
model of the Selberg sieve, formalized in Lean 4 using Mathlib. Zero `sorry`;
axiom footprint verified as `[propext, Classical.choice, Quot.sound]` for all
18 theorems (see `RequestProject/Audit.lean`).

## What This Project Is

This project formalizes four results about an explicit finite construction:
the **single-prime Selberg majorant** ν on Fin(d·m), defined by
ν(x) = 1 if d∤x and ν(x) = 1/2 if d∣x, with one sieving prime d.

This is **not** the full Selberg sieve. The actual Selberg sieve operates
over a product of primes P = p₁·····pₖ with weights λ_d defined for all
squarefree d | P. Everything in Theorems 1 and 2 is the single-prime case.
Whether the quadratic form identity extends to multiple sieving primes is
open and is not addressed here.

The four results are:

1. **Sieve improvement** (single-prime): ν has strictly smaller L¹ mass
   and L² norm than the constant baseline ν₀ ≡ 1, and the normalized L²
   norm equals the Selberg quadratic form Q(λ) at λ₁ = 1, λ_d = −1/2.
2. **Restriction lower bound** (abstract): any nonneg majorant dominating
   a sifted indicator satisfies `mass² · ‖ν‖₂² ≥ |S|⁴ / N`. This follows
   directly from Cauchy–Schwarz and pointwise domination in four steps.
   It is not in dialogue with Green–Tao restriction theory, which concerns
   Fourier decay on non-zero frequencies and goes in the opposite direction.
3. **Kinetic propagation** (abstract): if f(p) and g(p) agree to within ε
   at every prime, then `|f(d) − g(d)| ≤ ε · ω(d) · M^(ω(d)−1)` for
   squarefree d. Euler products and the H-functional are correspondingly
   stable. This result is logically independent of Theorems 1 and 2.
4. **Quadratic form stability**: the Selberg quadratic form Q(λ, f) is
   Lipschitz in f — if the density function is perturbed by ε at every
   squarefree divisor (controlled by the kinetic bound), then |Q(λ,f) −
   Q(λ,g)| is bounded by an explicit double sum. This is the theorem that
   establishes that the quadratic form value identified in Theorem 1 is stable
   under perturbations of the type controlled by Theorem 3 — providing the
   structural link, though no explicit perturbation is instantiated in
   the current scope.
   
## What This Project Is Not

- **Not the full Selberg sieve.** The concrete results (Theorems 1 and 2)
  apply to a single sieving prime only.
- **Not a deep restriction theorem.** The restriction lower bound is a
  direct consequence of Cauchy–Schwarz. It does not involve Fourier
  analysis and should not be compared to Green–Tao (2006) or
  Bera–Viswanadham (2025), which are upper bounds requiring Fourier
  hypotheses.
- **Not a proof of any asymptotic result.** No primes, no density
  estimates, no big-O.
- **Not a characterization of the Selberg majorant.** The project does
  not prove ν is extremal or minimal in any sense. The open question
  (whether ν minimizes the mass-energy product among all majorants
  dominating **1**_S) is not addressed.
- **`Future/`** is scaffolding only and is not part of the proof chain.

## Main Results

**Theorem 1 — Mass, L² Improvement, and Quadratic Form Identity**
(`Core/SelbergComparison.lean`, `Core/Weights/FourierConnection.lean`)

For all d ≥ 2, m ≥ 1, simultaneously:

    mass(ν) = dm − m/2  <  dm = mass(ν₀)
    ‖ν‖₂²  = dm − 3m/4  <  dm = ‖ν₀‖₂²

The normalized L² norm satisfies `‖ν‖₂²/(d·m) = 1 − 3/(4d)`, equal to
the Selberg quadratic form Q(λ) at λ₁ = 1, λ_d = −1/2. This identity
holds in the single-prime model only.

**Theorem 2 — Restriction Lower Bound**
(`Core/RestrictionLowerBound.lean`, `Core/SelbergRestriction.lean`)

For any nonneg ν on Fin(N) dominating the 0-1 indicator of a set S:

    mass(ν)² · ‖ν‖₂²  ≥  |S|⁴ / N

Proved from Cauchy–Schwarz and pointwise domination alone. The proof is
elementary and does not use Fourier analysis. A Fourier restatement
(`restriction_lower_bound_zero_mode`) is also verified,
showing the same bound is equivalent to a zero-frequency energy condition via
Parseval — but this is a restatement of the spatial proof, not an independent
Fourier argument. Instantiated for the Selberg
majorant:

    mass(ν)² · ‖ν‖₂²  ≥  (dm − m)⁴ / (dm)

Combined with the baseline upper bound from Theorem 1:

    (dm − m)⁴ / (dm)  ≤  mass(ν)² · ‖ν‖₂²  <  (dm)³

The Selberg majorant satisfies both bounds simultaneously. This is a
numerical fact about the single-prime construction, not a characterization.

**Theorem 3 — Kinetic Propagation**
(`Core/KineticPropagation.lean`)

If two multiplicative sieve density functions f, g satisfy |f(p) − g(p)| ≤ ε
at every sieving prime, then for squarefree d with ω(d) = k prime factors
each bounded by M:

    |f(d) − g(d)|  ≤  ε · k · M^(k−1)

Pointwise, exact, no big-O. The partial Euler products and arithmetic
H-functional are correspondingly stable. This result holds for arbitrary
multiplicative functions and is independent of the Selberg construction.

**Theorem 4 — Quadratic Form Stability**
(`Core/Weights/QuadFormStability.lean`)

The Selberg quadratic form Q(λ, f) = Σ_{d,e} λ_d · λ_e / f(lcm(d,e))
is Lipschitz in f: if the kinetic propagation bound of Theorem 3 controls
|f(n) − g(n)| at every squarefree n, then

    |Q(λ, f) − Q(λ, g)|  ≤  explicit double sum in ε

This is the proof-chain connection between Theorems 1 and 3: It establishes 
that the quadratic form value identified in Theorem 1 is stable under 
perturbations of the type controlled by Theorem 3. Without this theorem, the
connection between Theorems 1 and 3 is narrative only.

## Scope of Novelty

We are not aware of the following appearing in the literature in this form:

1. The pointwise Lipschitz bound of Theorem 3 stated explicitly in
   Iwaniec–Kowalski, Tao's 254A notes, Ford's sieve notes, or
   Mathlib's `SelbergSieve`.
2. The machine-verified identity `‖ν‖₂²/N = Q(λ)` with explicit dual
   improvement in the single-prime model.
3. `Nat.Squarefree.lcm` as a named lemma in Mathlib (absent as of v4.28.0).
4. The Lipschitz stability of the Selberg quadratic form as a machine-
   verified theorem (Theorem 4).

We make no claim to have surveyed all literature exhaustively, and we do
not claim novelty for the restriction lower bound (Theorem 2), which is
a straightforward consequence of Cauchy–Schwarz.

## Axiom Audit

All 18 theorems verified with `#print axioms` (see `RequestProject/Audit.lean`):

```
── Theorem 1 ────────────────────────────────────────────────────────────────
selbergComparison_massImprovement       → [propext, Classical.choice, Quot.sound]
sieveMajorant_l2_improvement            → [propext, Classical.choice, Quot.sound]
selbergComparison_dual_improvement      → [propext, Classical.choice, Quot.sound]
sieveMajorant_l2NormSq_eq_selbergForm   → [propext, Classical.choice, Quot.sound]

── Theorem 2 ────────────────────────────────────────────────────────────────
restriction_lower_bound                 → [propext, Classical.choice, Quot.sound]
sieve_additive_energy_lower             → [propext, Classical.choice, Quot.sound]
restriction_lower_bound_zero_mode       → [propext, Classical.choice, Quot.sound]

── Theorem 3 ────────────────────────────────────────────────────────────────
perturbation_propagates                 → [propext, Classical.choice, Quot.sound]
eulerProduct_stability                  → [propext, Classical.choice, Quot.sound]
sieveH_stable                           → [propext, Classical.choice, Quot.sound]

── Instantiations ───────────────────────────────────────────────────────────
selberg_restriction_lower_bound_explicit → [propext, Classical.choice, Quot.sound]
selberg_additive_energy_explicit        → [propext, Classical.choice, Quot.sound]
selberg_mass_energy_interval            → [propext, Classical.choice, Quot.sound]

── Theorem 4 ────────────────────────────────────────────────────────────────
Nat.Squarefree.lcm                      → [propext, Classical.choice, Quot.sound]
inv_diff_bound                          → [propext, Classical.choice, Quot.sound]
quadForm_term_diff                      → [propext, Classical.choice, Quot.sound]
quadForm_term_bound                     → [propext, Classical.choice, Quot.sound]
quadForm_kinetic_stability              → [propext, Classical.choice, Quot.sound]
```

Zero `sorry`. Classical logic only.

## AI Assistance

This project is a human–AI collaboration. Mathematical direction, theorem
statements, proof strategies, novelty identification, and scope decisions
were made by the human author. AI assistance was used for tactic search,
proof elaboration, and infrastructure lemmas. All mathematical claims were
decided and verified by the human author.

## Build

```bash
lake exe cache get
lake build
```

Requires Lean toolchain `leanprover/lean4:v4.28.0` (see `lean-toolchain`).

## File Map

```
RequestProject/
├── Audit.lean                        ← #print axioms for all 18 theorems
├── AssumptionsRegistry.lean          ← Manually maintained proof-status log
├── Main.lean                         ← Top-level imports
└── Core/
    ├── Basic.lean                    ← SieveData structure and multiplicativity
    ├── Majorant.lean                 ← Abstract majorant structure
    ├── MajorantComparison.lean       ← Toy benchmark (sanity check only)
    ├── SelbergComparison.lean        ← Theorem 1: mass improvement
    ├── SelbergRestriction.lean       ← Theorem 2: Selberg instantiation + interval
    ├── RestrictionLowerBound.lean    ← Theorem 2: abstract Cauchy–Schwarz form
    ├── KineticPropagation.lean       ← Theorem 3: kinetic propagation
    ├── Fourier.lean                  ← DFT, Parseval, additive energy
    ├── FourierRatio.lean             ← mass² · ‖ν‖₂² tradeoff
    ├── Transference.lean             ← Pseudorandomness structures (scaffolding only)
    └── Weights/
        ├── Definition.lean           ← SelbergWeights structure and quadForm
        ├── Bounds.lean
        ├── Optimization.lean         ← Cauchy–Schwarz on quadratic form
        ├── UpperBound.lean           ← Selberg upper bound
        ├── FourierConnection.lean    ← Theorem 1: L² identity, dual improvement
        └── QuadFormStability.lean    ← Theorem 4: Q(λ,f) Lipschitz in f

Future/                               ← Scaffolding; not part of proof chain
formalization.yml                     ← Machine-readable project metadata
```
