---
title: "Finance Tracker"
subtitle: "Single-Owner Personal Finance Application with Integer-Rupiah Accounting"
category: "SYSTEMS & DATA"
status: "v1.0.0 // SELF-HOSTED // CI-VERIFIED"
timeline: "Oct 2026"
role: "Solo Developer (Full-Stack)"
techStack: ["Python", "FastAPI", "SQLModel", "SQLite", "Alembic", "React", "TypeScript", "TanStack Query", "Docker"]
metrics:
  - label: "Monetary Model"
    value: "Integer Rupiah"
    detail: "BIGINT column with a CHECK constraint; amounts cross the API as digit strings, so no floating point is involved"
  - label: "Authentication"
    value: "Argon2id + Session"
    detail: "Optional owner mode with HttpOnly cookies; session tokens stored as SHA-256 hashes"
  - label: "Safe Migrations"
    value: "Alembic + Backup"
    detail: "A verified SQLite backup snapshot is taken before upgrades; the migration aborts if the backup fails"
githubUrl: "https://github.com/reshandytaftazani/finance-tracker"
runCommand: "cd backend && python -m scripts.migrate && python -m scripts.seed && python -m app"
featured: true
---

## 1. Overview

Finance Tracker is a personal finance application for a single owner, designed to run locally or on a private host. It covers transactions, categories, wallets, transfers, monthly budgets and spending analytics, with a React interface in Indonesian and IDR as the currency.

## 2. Problem

Personal finance tools commonly store money as floating-point numbers, accumulating rounding drift, and accept loosely validated input. For a ledger that someone relies on, correctness has to be enforced by the data model, not by careful callers.

## 3. Approach

- **Backend:** FastAPI with SQLModel on SQLite; routers (`app/api`) call services (`app/services`) that operate on typed models and schemas.
- **Frontend:** React + TypeScript + Vite, styled with Tailwind CSS v4 and shadcn/ui; TanStack Query handles server-state caching and invalidation after mutations.
- **Delivery:** multi-stage Docker build (frontend builder, Python runtime) serving the SPA and API from one origin, with persistent volumes for the database and backups, a health check and a single-instance constraint suited to SQLite.

## 4. Engineering Decisions

| Concern | Decision |
|---|---|
| Money representation | Integer rupiah with `CHECK typeof(amount_rupiah) = 'integer'` and bounded range; API amounts are digit strings; ids beyond `Number.MAX_SAFE_INTEGER` are rejected in the browser instead of being silently rounded |
| Data isolation | The server assigns the owner; clients cannot submit `owner_id` or `normalized_name`; categories in use cannot be deleted or retyped |
| Authentication | Default local mode, or owner mode with Argon2id; no public registration endpoint (password is set through a local CLI); HttpOnly session cookie |
| Request safety | Host and origin checks on mutating requests |
| Schema evolution | Alembic with transactional DDL; databases with unrecognized legacy schemas are refused rather than overwritten; automatic pre-upgrade snapshot via the SQLite backup API with an integrity check |
| Operations | Routine backup and restore scripts, health endpoint, containerized deployment bound to loopback by default |
| Quality gates | CI runs Ruff and pytest for the backend, and type-check, lint and tests for the frontend |

## 5. Features

Transaction CRUD with month/category/type filters, pagination and partial updates · wallets and transfers · monthly category budgets with 80% and 100% alerts · dashboard with income, expense, net cash flow and category breakdown · analytics with forecast and backtest evaluation · safe CSV export.

## 6. Scope & Status

Released as **v1.0.0**. Built for one owner on one machine. PostgreSQL migrations have been checked as offline DDL only and not yet on a live server, and full 64-bit id support in the UI is not available. No load benchmarks have been run, so no throughput or latency figures are claimed.
