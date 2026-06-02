-- SieveFormalization: Core verified results
-- Three theorems about the Selberg sieve, machine-verified in Lean 4 / Mathlib.
--
-- Paper 1 (Kinetic Propagation):     Core/KineticPropagation.lean
-- Paper 2 (Restriction Lower Bound): Core/RestrictionLowerBound.lean
-- Paper 3 (Fourier–Sieve Identity):  Core/Weights/FourierConnection.lean
--
-- Future/ contains scaffolding for future work.
-- Nothing there is part of the proof chain for Papers 1–3.

-- ── Core sieve infrastructure ───────────────────────────────────────────────
import RequestProject.Core.Basic
import RequestProject.Core.Weights.Definition
import RequestProject.Core.Weights.Bounds
import RequestProject.Core.Weights.UpperBound
import RequestProject.Core.Weights.Optimization
import RequestProject.Core.Majorant
import RequestProject.Core.MajorantComparison
import RequestProject.Core.SelbergComparison
import RequestProject.Core.Fourier
import RequestProject.Core.FourierRatio
import RequestProject.Core.Transference

-- ── Paper 1: Kinetic Propagation ────────────────────────────────────────────
import RequestProject.Core.KineticPropagation

-- ── Paper 2: Restriction Lower Bound ────────────────────────────────────────
import RequestProject.Core.RestrictionLowerBound
import RequestProject.Core.SelbergRestriction

-- ── Paper 3: Fourier–Sieve Identity ─────────────────────────────────────────
import RequestProject.Core.Weights.FourierConnection

-- ── Central registry ─────────────────────────────────────────────────────────
import RequestProject.AssumptionsRegistry

-- ── Future work (not part of current proof chain) ────────────────────────────
-- Uncomment to build scaffolding:
-- import RequestProject.Future.Dynamics.ProfiniteState
-- import RequestProject.Future.Dynamics.SieveState
-- import RequestProject.Future.Dynamics.Spectrum
-- import RequestProject.Future.Hybrid.KineticLaw
-- import RequestProject.Future.Hybrid.ErgodicMajorant
-- import RequestProject.Future.Models.CyclicToy
-- import RequestProject.Future.Models.RandomSieve
-- import RequestProject.Future.Models.FunctionField
-- import RequestProject.Future.Applications.FunctionFieldSieve
-- import RequestProject.Future.Applications.TransferenceLike
-- import RequestProject.Future.Applications.ChenLike
-- import RequestProject.Future.Applications.AffineLike
