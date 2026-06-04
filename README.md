# Selberg Majorant Improvement: A Lean 4 Formalization

Machine-verified proofs of three results about the Selberg majorant on Fin(N),
formalized in Lean 4 using Mathlib. Zero `sorry` in `Core/`; axiom footprint
verified as `[propext, Classical.choice, Quot.sound]` for all 13 main theorems
(see `RequestProject/Audit.lean`).

## What This Project Is

This project examines a single explicit finite construction — the Selberg majorant
ν on Fin(d·m), defined by ν(x) = 1 if d∤x and ν(x) = 1/2 if d∣x — and identifies
three independently motivated constraints that are simultaneously active on it:

1. **Sieve improvement**: ν has strictly smaller L¹ mass and L² norm than the
   constant baseline ν₀ ≡ 1, and the normalized L² norm equals the Selberg
   quadratic form Q(λ) at λ₁ = 1, λ_d = −1/2.
2. **Restriction**: any nonneg majorant dominating a sifted indicator satisfies
   `mass(ν)² · ‖ν‖₂² ≥ |S|⁴ / N`, proved from Cauchy–Schwarz alone.
3. **Kinetic stability**: if f(p) is perturbed by ε at each prime, then
   `|f(d) − g(d)| ≤ ε · ω(d) · M^(ω(d)−1)` for squarefree d, with
   corresponding stability for Euler products and the arithmetic H-functional.

As general statements these three are logically independent: the restriction lower
bound holds for all nonneg majorants, the kinetic propagation theorem holds for all
multiplicative functions, and the quadratic form identity is specific to the Selberg
construction. **The central claim of the project is that these constraints are not
independent for this specific object.** The weight λ_d = −1/2 that achieves the
sieve improvement also produces the exact values appearing in the restriction bound,
and all scalar invariants of ν — mass, L² norm, H-functional — are Lipschitz in
the prime-level data. Stability is the sensitivity analysis for the quadratic form
identity; restriction and sieve improvement constrain the mass-energy product from
opposite directions:

$$\frac{(dm-m)^4}{dm} \;\leq\; \mathrm{mass}(\nu)^2 \cdot \|\nu\|_2^2 \;<\; (dm)^3$$

The Selberg majorant lies strictly inside this interval. Whether it minimizes the
mass-energy product among all nonneg majorants dominating **1**_S is open.

## Main Results

**Theorem 1 — Mass and L² Improvement**
(`Core/SelbergComparison.lean`, `Core/Weights/FourierConnection.lean`)

For all d ≥ 2, m ≥ 1, simultaneously:

    mass(ν) = dm − m/2  <  dm = mass(ν₀)
    ‖ν‖₂²  = dm − 3m/4  <  dm = ‖ν₀‖₂²

The normalized L² norm satisfies `‖ν‖₂²/(d·m) = 1 − 3/(4d)`, equal to the
Selberg quadratic form Q(λ) at λ₁ = 1, λ_d = −1/2 in the single-prime model.

**Theorem 2 — Restriction Lower Bound**
(`Core/RestrictionLowerBound.lean`, `Core/SelbergRestriction.lean`)

For any nonneg ν on Fin(N) dominating the 0-1 indicator of a set S:

    mass(ν)² · ‖ν‖₂²  ≥  |S|⁴ / N

No Fourier hypothesis required. Complementary to the restriction *upper* bounds
of Green–Tao (2006) and Bera–Viswanadham (2025), which go in the opposite
direction and require Fourier hypotheses. Instantiated for the Selberg majorant:

    mass(ν)² · ‖ν‖₂²  ≥  (dm − m)⁴ / (dm)

**Theorem 3 — Kinetic Propagation** (`Core/KineticPropagation.lean`)

If two multiplicative sieve density functions f, g satisfy |f(p) − g(p)| ≤ ε
at every sieving prime, then for squarefree d with ω(d) = k prime factors
each bounded by M:

    |f(d) − g(d)| ≤ ε · k · M^(k−1)

Pointwise, exact, no big-O. The partial Euler products and arithmetic
H-functional are correspondingly stable under the same perturbation.

## What Should Not be expected

- The concrete instantiations of Theorems 1 and 2 apply to the single-prime
  model only. Theorems 2 and 3 in abstract form are fully general.
- `Future/` is scaffolding for future work and is not part of the proof chain.
  Two entries in `Future/Applications/` are explicitly marked `AssumedForProgram`
  in `AssumptionsRegistry.lean`.
- The restriction lower bound is not tight for the Selberg majorant.
- The quadratic form identity does not generalize to multiple sieving primes
  without additional work.

## Scope of Novelty

We are not aware of the following appearing in the literature in this form:

1. The pointwise Lipschitz bound of Theorem 3 in Iwaniec–Kowalski, Tao's 254A
   notes, Ford's sieve notes, or Mathlib's `SelbergSieve`.
2. The abstract restriction lower bound of Theorem 2 without a Fourier hypothesis.
3. The machine-verified identity `‖ν‖₂²/N = Q(λ)` with explicit dual improvement.
4. The simultaneous-constraints framing: the interval
   `(dm−m)⁴/dm ≤ mass²·‖ν‖₂² < (dm)³` as the combined consequence of
   Theorems 1 and 2 applied to the same object.


## Axiom Audit

All 13 main theorems verified with `#print axioms` (see `RequestProject/Audit.lean`):

```

selbergComparison_massImprovement       → [propext, Classical.choice, Quot.sound]
sieveMajorant_l2_improvement            → [propext, Classical.choice, Quot.sound]
selbergComparison_dual_improvement      → [propext, Classical.choice, Quot.sound]
sieveMajorant_l2NormSq_eq_selbergForm   → [propext, Classical.choice, Quot.sound]
restriction_lower_bound                 → [propext, Classical.choice, Quot.sound]
sieve_additive_energy_lower             → [propext, Classical.choice, Quot.sound]
restriction_lower_bound_zero_mode       → [propext, Classical.choice, Quot.sound]
perturbation_propagates                 → [propext, Classical.choice, Quot.sound]
eulerProduct_stability                  → [propext, Classical.choice, Quot.sound]
sieveH_stable                           → [propext, Classical.choice, Quot.sound]
selberg_concrete_restriction_bound      → [propext, Classical.choice, Quot.sound]
selberg_additive_energy_explicit        → [propext, Classical.choice, Quot.sound]
selberg_mass_energy_interval            → [propext, Classical.choice, Quot.sound]
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
├── Audit.lean                        ← #print axioms for all 13 main theorems
├── AssumptionsRegistry.lean          ← Manually maintained proof-status log
├── Main.lean                         ← Top-level imports
└── Core/
    ├── Basic.lean                    ← SieveData structure and multiplicativity
    ├── Majorant.lean                 ← Abstract majorant structure
    ├── MajorantComparison.lean       ← Toy benchmark (sanity check only)
    ├── SelbergComparison.lean        ← Theorem 1: mass improvement
    ├── SelbergRestriction.lean       ← Theorem 2: Selberg instantiation + Section 6 interval
    ├── RestrictionLowerBound.lean    ← Theorem 2: abstract form
    ├── KineticPropagation.lean       ← Theorem 3
    ├── Fourier.lean                  ← DFT, Parseval, additive energy
    ├── FourierRatio.lean             ← mass² · ‖ν‖₂² tradeoff
    ├── Transference.lean             ← Transference infrastructure
    └── Weights/
        ├── Definition.lean           ← SelbergWeights structure
        ├── Bounds.lean
        ├── Optimization.lean         ← Cauchy–Schwarz on quadratic form
        ├── UpperBound.lean           ← Selberg upper bound
        └── FourierConnection.lean    ← Theorem 1: L² identity, dual improvement

Future/                               ← Scaffolding; not part of proof chain
formalization.yml                     ← Machine-readable project metadata
```


## Citation

> Aziz, A. (2026). *Rigidity of the Selberg Majorant: Stability, Restriction,
> and a Quadratic Form Identity with Machine-Verified Proofs*. Zenodo.
> https://doi.org/10.5281/zenodo.20515354

```bibtex
@misc{aziz2026selberg,
  author    = {Aziz, Arij},
  title     = {Rigidity of the {S}elberg Majorant: Stability, Restriction,
               and a Quadratic Form Identity with Machine-Verified Proofs},
  year      = {2026},
  publisher = {Zenodo},
  doi       = {10.5281/zenodo.20515354},
  url       = {https://doi.org/10.5281/zenodo.20515354}
}
```

