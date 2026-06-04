-- Audit.lean: axiom footprint for all main theorems.
-- Expected for each: [propext, Classical.choice, Quot.sound]
-- Any 'sorry' invalidates the proof chain.

import RequestProject.Core.SelbergComparison
import RequestProject.Core.KineticPropagation
import RequestProject.Core.RestrictionLowerBound
import RequestProject.Core.Weights.FourierConnection
import RequestProject.Core.SelbergRestriction
import RequestProject.Core.Weights.QuadFormStability
import RequestProject.Core.Weights.UpperBound

-- ── Theorem 1: Mass and L² improvement ──────────────────────────────────────
#print axioms selbergComparison_massImprovement
#print axioms sieveMajorant_l2_improvement
#print axioms selbergComparison_dual_improvement
#print axioms sieveMajorant_l2NormSq_eq_selbergForm

-- ── Theorem 2: Restriction lower bound ──────────────────────────────────────
#print axioms restriction_lower_bound
#print axioms sieve_additive_energy_lower
#print axioms restriction_lower_bound_zero_mode

-- ── Selberg upper bound infrastructure ───────────────────────────────────────
#print axioms siftedSet_card_le_quadraticSum
#print axioms weighted_remainder_bound

-- ── Theorem 3: Kinetic propagation ──────────────────────────────────────────
#print axioms perturbation_propagates
#print axioms eulerProduct_stability
#print axioms sieveH_stable

-- ── Concrete instantiations ──────────────────────────────────────────────────
#print axioms selberg_concrete_restriction_bound
#print axioms selberg_additive_energy_explicit
#print axioms selberg_mass_energy_interval

-- ── Theorem 4: Quadratic form stability ──────────────────────────────────────
#print axioms quadForm_kinetic_stability
#print axioms quadForm_term_bound
#print axioms quadForm_term_diff
#print axioms inv_diff_bound
#print axioms Nat.Squarefree.lcm
