import RequestProject.Core.SelbergComparison
import RequestProject.Core.KineticPropagation
import RequestProject.Core.RestrictionLowerBound
import RequestProject.Core.Weights.FourierConnection

-- Axiom audit. Expected output: [propext, Classical.choice, Quot.sound]
-- Any 'sorry' here means the proof chain is unsound.
#print axioms selbergComparison_massImprovement
#print axioms perturbation_propagates
#print axioms restriction_lower_bound
#print axioms sieveMajorant_l2_improvement
