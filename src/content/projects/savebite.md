---
title: "SaveBite"
subtitle: "Food Waste Reduction Platform — Team Project, Universitas Indonesia"
category: "PLATFORM & WEB"
status: "COMPLETED // DEPLOYED // COURSEWORK"
timeline: "Sep — Oct 2026"
role: "Developer, Module 4: Food Rescue Request Board (Team of 5)"
techStack: ["Django", "Python", "PostgreSQL", "SQLite (local)", "HTML/CSS/JavaScript", "GitHub Actions"]
metrics:
  - label: "Context"
    value: "PBP Class D, Group 8"
    detail: "Five-person team project for Platform-Based Programming at Fasilkom UI, deployed on the faculty PWS platform"
  - label: "Contribution"
    value: "88 of 212 commits"
    detail: "Request Board module plus cross-module fixes (dark mode, production CSRF origin); counted from git history"
  - label: "Data Integrity"
    value: "DB-Level Constraints"
    detail: "Unique offers per request and bidder, CHECK constraints on quantity, status and unit, idempotent request creation"
githubUrl: "https://github.com/PBP-D-Kelompok-8/SaveBite"
runCommand: "python manage.py runserver"
featured: true
---

## 1. Overview

SaveBite is a web platform that helps students and households reduce food waste. Five modules cover a leftover-ingredient recipe catalog (TheMealDB), a food rescue planner, community recipes, an ingredient request board and a food journal. It was built as a Django (MVT) application by a five-person team, each member owning one module.

## 2. My Module: Food Rescue Request Board

A forum-style board where community members request small amounts of surplus ingredients instead of buying new ones.

**Flow.** A user posts a request → other users respond with "Saya Punya!" → the owner reviews offers, selects a helper and marks the request fulfilled, or deletes it.

**Access model.** Visitors can browse, search and filter. Signed-in users can create requests and make offers. Only the owner can choose a helper, mark fulfillment or delete the request.

**Capabilities.** Title search, ingredient/location/status filters, newest/oldest ordering, pagination (20 per page), and a derived "expired" status computed from `expires_at`.

## 3. Engineering Decisions

| Concern | Decision |
|---|---|
| Duplicate submissions from repeated clicks or slow networks | `RequestCreationKey`: a per-owner UUID with a payload digest makes creation idempotent; keys are retained at least 30 days and purged by a management command |
| One offer per user per request | `UniqueConstraint(request, offered_by)` |
| Invalid data bypassing the application layer | `CheckConstraint` rules for quantity > 0 and valid status and unit values, enforced in the database |
| Business logic leaking into views | A service layer (`create_request_idempotent`, `offer_request`, `select_request_offer`, `fulfill_request`, `delete_request`) |
| Schema evolution | Six migrations tracking features as they were added (offers, selected offer, expiry, creation keys, index) |

## 4. Documentation & Transparency

The module ships with a README (usage, roles, statuses), an operations guide for maintenance, and an AI-use disclosure.

## 5. Notes

Production runs on PostgreSQL and local development on SQLite. Authentication uses Django sessions with CSRF protection. Latency has not been benchmarked, so no performance figures are stated.
