---
title: "ModelArena"
subtitle: "Local-First ML Experimentation Platform with Leakage-Safe Evaluation"
category: "MACHINE LEARNING"
status: "IN DEVELOPMENT // DAY 20 OF 28 // GATES G1–G2 PASSED"
timeline: "Oct 2026 — Present"
role: "Solo Developer"
techStack: ["Python 3.12", "scikit-learn", "PyTorch (CPU)", "MLflow", "FastAPI", "SQLite", "pandas", "NumPy", "uv"]
metrics:
  - label: "Delivery"
    value: "Day 20 / 28"
    detail: "Gates G1 (data correctness) and G2 (classical experiments) passed locally; G3 in progress, G4 not started"
  - label: "Reproducibility"
    value: "Δ ≤ 1e-6 abs"
    detail: "Repeated 5-fold CV under identical seeds matched within abs 1e-6 / rel 1e-5 (observed max deviation 0.0, timings excluded)"
  - label: "Evaluation Integrity"
    value: "Fold-local"
    detail: "Imputation, scaling and encoding are fitted inside each training fold; the holdout is evaluated exactly once"
githubUrl: "https://github.com/reshandytaftazani/modelarena"
runCommand: "uv run --locked python -m apps.api.server"
featured: true
---

## 1. Overview

ModelArena is a local-first platform for running and auditing machine-learning experiments on tabular data. It runs entirely on a CPU laptop with no GPU, cloud service or paid API, and it is built around one idea: **an experiment is only as trustworthy as its evaluation protocol.**

## 2. Problem

A high score can be an artifact of the process rather than the model: preprocessing fitted before cross-validation, model selection against test results, early stopping on the data used for reporting, or no baseline to compare against. ModelArena encodes the correct protocol so these mistakes are structurally difficult rather than a matter of discipline.

## 3. Approach

**Evaluation protocol**
1. Reserve a holdout (default 80/20, stratified for binary classification); profile data from the training partition only.
2. Compare candidates on shared folds: a Dummy baseline, LogisticRegression, RandomForest, HistGradientBoosting and a small PyTorch MLP (two hidden layers, 64 and 32 units).
3. Rank by a metric fixed in advance (F1/AP for classification, RMSE/MAE for regression); holdout results never influence ranking.
4. Refit the selected model on the full training partition and evaluate the holdout once, guarded by a single-use capability token and a durable plan that binds the refit to its CV evidence.

**System design**
```
FastAPI (validation, job queue) ──> Application SQLite (job state, holdout locks)
Worker supervisor ──> one spawned CPU child ──> ML protocol modules (ml/)
                                           └──> Local MLflow, private artifacts, offline report
```
Training never runs on a request thread. API and ML code live in separate packages (`apps/api`, `ml`).

## 4. Engineering Decisions

| Concern | Decision |
|---|---|
| Preprocessing leakage | Fresh fold-local transformers per fold; the shared output boundary is guarded |
| MLP early stopping | Inner validation split taken from the training fold only; outer validation and holdout never touched (verified with row-ID spies) |
| Final MLP epoch budget | `ceil(median(best epochs))` over successful CV folds, bounded to 1–100 |
| Long-running jobs | Durable SQLite queue, supervised child process, cancellation, orphan blocking, fencing and restart reconciliation |
| Reproducibility | Seed study (42/43/44) separates model-seed variance from split-seed variance, with zero holdout access |
| Reporting | Offline ZIP (HTML/JSON/inline SVG) with escaped output; no raw rows, model binaries or external assets |
| Model artifacts | Private checksummed storage; untrusted serialized models are rejected |

## 5. Scope & Status

| Work package | State |
|---|---|
| Data validation, splits, fold-local preprocessing, Dummy CV | Complete (G1 passed locally) |
| Classical suite, CV comparison, MLflow, guarded holdout gate | Complete (G2 passed locally) |
| PyTorch CPU MLP, fold-local early stopping, refit, final evaluation, offline report | Verified locally |
| Reproducibility fixtures and seed study (Day 20) | Verified locally, review pending |
| Full CPU workload profiling, React dashboard, G3, G4 | In progress / planned |

**Boundaries.** CPU-only; Windows is the initial verification platform. The MVP covers binary classification and regression on independent tabular rows; multiclass, time series, multi-user and distributed training are out of scope. The dashboard is not built yet, and performance figures will be published only after the planned profiling.
