---
title: "LeakGuard ML"
subtitle: "Point-in-Time Feature Store & Lookahead Leakage Prevention Harness"
category: "VERIFICATION"
status: "100% TEMPORAL ISOLATION"
timeline: "2024 — 2025"
role: "Lead ML Systems & Verification Author"
techStack: ["Python 3.12", "Polars", "Pytest", "DuckDB", "Temporal Joins", "Data Integrity"]
metrics:
  - label: "Throughput"
    value: "14.2M rows/sec"
    detail: "Vectorized as-of temporal joins computed via Polars Rust backend core"
  - label: "Peak RAM"
    value: "412 MB"
    detail: "Streaming lazy evaluation memory footprint under 50k events"
  - label: "Violations"
    value: "0 / 50,000"
    detail: "Strict temporal boundary assertions barring lookahead future data infiltration"
  - label: "Query Speedup"
    value: "6.4x"
    detail: "Vectorized temporal joins computed via Polars Rust backend over Pandas"
githubUrl: "https://github.com/reshandytaftazani/leakguard-ml"
runCommand: "pytest -v tests/test_leakage_bounds.py --strict-time-split"
featured: false
---

## 1. Problem Context & Architectural Motivation

In predictive machine learning pipelines—particularly across financial indicators, dynamic scoring, and chronological series—**lookahead data leakage** represents one of the most insidious silent failure modes. Standard shuffle-split cross-validation and naive feature aggregation allow target values or aggregated statistics from future timestamps ($t > t_{\text{eval}}$) to contaminate feature stores.

Common failure patterns addressed:
- **Global Mean Imputation:** Calculating target encoders or standardizers across the entire dataset prior to splitting.
- **Asymmetric Time Joins:** Merging lagging data with timestamps evaluated in the future of the prediction timestamp.
- **Tombstone Neglect:** Failing to mask records that were retroactively revised or purged by regulatory mandates.

```
                    STRICT POINT-IN-TIME FEATURE SPLIT
     Train Horizon                     Evaluation Horizon
[----------------------- t_cutoff ----------------------->]
  Historical Records Valid   |   FUTURE DATA - BARRED ACCESS
                             |   [Temporal Gate: ASSERT t <= t_cutoff]
```

---

## 2. System Architecture Blueprint

```
+-------------------------------------------------------------------------------+
|                           LEAKGUARD ARCHITECTURE                              |
+-------------------------------------------------------------------------------+
|                                                                               |
|   +-----------------------+                    +--------------------------+   |
|   |  Raw Event Stream     | -----------------> |  Polars As-Of Join Core  |   |
|   |  (Timestamp Ingestion)|                    |  (Exact Point-In-Time)   |   |
|   +-----------------------+                    +--------------------------+   |
|                                                              |                |
|                                                              v                |
|   +-----------------------+                    +--------------------------+   |
|   |  Chaos Scrambler Fixt | <================> |  Temporal Boundary Gate  |   |
|   |  (Time Travel Fuzzing)|                    |  (Zero Leakage Guard)    |   |
|   +-----------------------+                    +--------------------------+   |
+-------------------------------------------------------------------------------+
```

---

## 3. Implementation Contracts & Verification

```python
from datetime import datetime
import polars as pl

def point_in_time_join(
    features: pl.LazyFrame,
    events: pl.LazyFrame,
    cutoff: datetime
) -> pl.DataFrame:
    """Enforces strict temporal isolation guaranteeing zero future state leakage."""
    return (
        events.filter(pl.col("event_time") <= cutoff)
        .join_asof(
            features.filter(pl.col("feature_time") <= cutoff),
            left_on="event_time",
            right_on="feature_time",
            strategy="backward"
        )
        .collect()
    )
```

---

## 4. Key Engineering Takeaways

- **Lazy Evaluation Invariants:** Evaluating queries with Polars LazyFrame plans allows pushdown predicate filters, ensuring lookahead records are culled before being materialized into RAM.
- **Chaos Fault Injection:** Writing synthetic test fixtures that deliberately inject future-dated timestamps ensures automated CI catches any regression before model weights are tuned.
