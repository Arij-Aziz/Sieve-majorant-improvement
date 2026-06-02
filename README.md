# Selberg Improvement: A Lean 4 Formalization

Machine-verified proofs of three results in Selberg sieve theory,
formalized in Lean 4 using Mathlib. Zero `sorry` statements in `Core/`.

## What This Is

**Theorem 1 — Kinetic Propagation** (`Core/KineticPropagation.lean`)

If two multiplicative sieve density functions f, g satisfy |f(p) − g(p)| ≤ ε
at every sieving prime, then for squarefree d with ω(d) = k prime factors bounded by M:

    |f(d) − g(d)| ≤ ε · k · M^(k−1)

Pointwise, exact, no big-O.

**Theorem 2 — Restriction Lower Bound** (`Core/RestrictionLowerBound.lean`)

For any nonneg ν on Fin(N) dominating a 0-1 indicator of a set S:

    mass(ν)² · ‖ν‖₂² ≥ |S|⁴ / N

Proved from Cauchy–Schwarz and pointwise domination alone. No Fourier hypothesis required.

**Theorem 3 — Fourier–Sieve Identity + Dual Improvement** (`Core/Weights/FourierConnection.lean`)

For the Selberg majorant ν on Fin(d·m) defined by ν(x) = 1 if d∤x, ν(x) = 1/2 if d∣x:

    ‖ν‖₂² / (d·m)  =  1 − 3/(4d)

This equals the Selberg quadratic form Q(λ) at λ₁ = 1, λ_d = −1/2.
The majorant simultaneously satisfies mass(ν) < mass(ν₀) and ‖ν‖₂² < ‖ν₀‖₂²
for all d ≥ 2, where ν₀ ≡ 1 is the constant baseline.

## What This Is Not

- Not a proof of Goldbach, twin primes, or any asymptotic result.
- The closed-form bounds (Theorem 2 instantiated, Theorem 3) apply to the
  **single-prime model** only. The abstract theorems (Theorem 1, abstract Theorem 2)
  are fully general.
- `Future/` is scaffolding for future work. Nothing there is a verified theorem
  of this project. Two results in `Future/Applications/` are explicitly marked
  `AssumedForProgram` in `AssumptionsRegistry.lean`.
- Green–Tao (2006) and Bera–Viswanadham (2025) prove restriction *upper* bounds
  requiring Fourier hypotheses. Theorem 2 here is a *lower* bound requiring no
  Fourier hypothesis. These are complementary results.

## Where the Novelty Lies

1. The pointwise Lipschitz bound of Theorem 1 does not appear in Iwaniec–Kowalski,
   Tao's 254A notes, Ford's sieve notes, or Mathlib's `SelbergSieve`.
2. The abstract restriction lower bound (Theorem 2) is logically distinct from all
   prior restriction upper bound results.
3. The machine-verified identity of Theorem 3 bridges two independently defined
   objects. The dual improvement (simultaneous mass and L² reduction) is not stated
   in this form in any prior source.
4. The arithmetic H-functional (`sieveHFunctional`) and its stability theorem are new objects.

## AI Assistance

This project is a human–AI collaboration.

- ~40% human: mathematical direction, theorem statements, proof strategies, novelty
  identification, scope decisions.
- ~60% AI-assisted Aristotle, GPT5.4 via perplexity: tactic search, proof elaboration, infrastructure lemmas,
  helper definitions.

All mathematical claims were decided and verified by the human author.

## Build

```bash
lake exe cache get
lake build
```

## File Map

```
Core/
├── KineticPropagation.lean       ← Theorem 1
├── RestrictionLowerBound.lean    ← Theorem 2 (abstract)
├── SelbergRestriction.lean       ← Theorem 2 (Selberg instantiation)
├── Majorant.lean                 ← Abstract majorant typeclass
├── SelbergComparison.lean        ← Selberg majorant construction
├── Fourier.lean / FourierRatio.lean
├── Basic.lean
├── MajorantComparison.lean
├── Transference.lean
└── Weights/
    ├── Definition.lean           ← SelbergWeights structure
    ├── Optimization.lean         ← Cauchy–Schwarz bound on quadratic form
    ├── UpperBound.lean           ← Selberg upper bound theorem
    ├── Bounds.lean
    └── FourierConnection.lean    ← Theorem 3

Future/                           ← Scaffolding; not part of proof chain
AssumptionsRegistry.lean          ← Complete proof-status inventory
```
