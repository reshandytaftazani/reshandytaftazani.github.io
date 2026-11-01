# Product & Design Specification: Dedicated Project Case Studies

## 1. Vision & Concept
- **Route:** `/projects/[slug]`
- **Purpose:** In-depth engineering case studies showcasing machine learning pipelines, inference runtimes, testing harnesses, and software architectures.
- **Aesthetic Authority:** Deep-Dark Technical Blueprint
  - 100% matte black canvas (`#0a0a0a`)
  - Hairline grid guidelines (`#1a1a1a`)
  - Safety orange accents (`#ff4500`)
  - JetBrains Mono and Hanken Grotesk typography
  - High-density ASCII/diagrammatic blueprints and terminal telemetry
  - Distinctly separated from the landing page's dual-canvas off-white poster style

## 2. Content Architecture (Astro Content Collections)
- **Directory:** `src/content/projects/[slug].md`
- **Schema:** Defined with Zod in `src/content/config.ts`:
  - `title`: string
  - `subtitle`: string
  - `category`: 'PIPELINES' | 'RUNTIMES' | 'VERIFICATION' | 'ARCHITECTURE'
  - `status`: string (e.g., 'VERIFIED_0.00%')
  - `timeline`: string
  - `role`: string
  - `techStack`: string[]
  - `metrics`: Array<{ label: string, value: string, detail: string }>
  - `githubUrl`: string
  - `runCommand`: string

## 3. Page Structure
1. **Header / Topbar:**
   - Tactile back control: `[← WORKS // ESC]`
   - Project indicator and live clock
2. **Hero Telemetry:**
   - Giant project title, subtitle, category pill, and primary status badge
   - Quick action badges: `[VIEW ON GITHUB ↗]`, `[RUN CLI]`, `[METRICS]`
3. **Problem Context & Root Cause:**
   - Why the system needed to be built, real-world failure modes addressed
4. **System Architecture Blueprint:**
   - Detailed ASCII/blueprint flow illustrating Ports, Adapters, and data boundaries
5. **Implementation & Code Contracts:**
   - Key code snippets, Pydantic/POSIX signal implementations, typing guarantees
6. **Benchmark & Defensive Verification Matrix:**
   - Latency, throughput, memory, and boundary isolation metrics
7. **Trade-offs & Lessons Learned:**
   - Engineering decisions, alternatives considered (e.g. ONNX vs TensorRT, Polars vs Pandas)
8. **Inter-Project Navigation:**
   - `[← PREV PROJECT]` and `[NEXT PROJECT →]` pagination

---

## 4. Multi-Page Architecture Roadmap

### Phase 1: Dedicated Project Case Studies [COMPLETED]
- **Route:** `/projects/[slug]`
- **Scope:** 3 Deep-Dark Technical Blueprint case studies (`modelarena`, `finance-tracker`, `savebite`).
- **Integration:** Two-tier card triggers on landing page (Title/Card -> `/projects/[slug]`, `[SPEC]` -> Quick modal, `[SOURCE ↗]` -> GitHub).

### Phase 2: Printable Swiss Technical CV (`/resume`) [COMPLETED]
- **Route:** `/resume`
- **Scope:** Clean, distraction-free, print-optimized (`@media print` cleanly formatted to single/dual A4 sheet) curriculum vitae.
- **Features:** 
  - Direct `[PRINT / SAVE PDF]` action button.
  - Plain text ATS-friendly copy button.
  - Structured academic coursework at Universitas Indonesia (2025—Present).
  - Systems & MLE skills matrix, verified open-source contributions.
  - Seamless navigation integration across Navbar (desktop & mobile drawer) and Hero action badges.

### Phase 3: Technical Field Notes & Engineering Journal (`/notes`)
- **Route:** `/notes` and `/notes/[slug]`
- **Scope:** Typography-driven chronological log of engineering dispatches and rigorous technical deep dives.
- **Sample Initial Dispatches:**
  - *Eliminating Lookahead Bias in Rolling Splits*
  - *POSIX Signal Traps in Async Python Inference Runtimes*
  - *Hexagonal Architecture for ML Feature Stores*
- **Features:** Reading time indicator, domain pills (`[SYSTEMS]`, `[DATA-INTEGRITY]`, `[RUNTIME]`), high-contrast code snippets.

